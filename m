Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74C56A21A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBXSip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:38:43 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2C2C668;
        Fri, 24 Feb 2023 10:38:34 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id nf5so76900qvb.5;
        Fri, 24 Feb 2023 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cbjyc/6vqLEWFE0JLAV3s9C1EpmcaDoeH9qzYsPDNeo=;
        b=kcrG6MvvTMGu/GH1zBlj8LUDnuiW9YRu+ac3tzWrMgnp5iN07gw9LbS1VXG1WeLPBC
         OqmdEDwfK47RVZA0VzJn3aZCqqSVuZVRepVGP1gpuTTewPygvti/XurH89MkfgAfdD6E
         /T6xzcjmg4zABRd4+K/vnWiqfqz1iMI6T0BJ308dk1Xlxb+Wo9dNjlgJb1pmq5qGdqd0
         nseD3jqnEA9n+3vCwAe6jzPDt08RgJYUk4ft/fxs5w8NhBiQ4MK+C9fzhu+Ts+nziQ49
         AQ8wi4osO1MMHi3qr3C4yYW8+oQW3vCDlB4Ubq4i8gHyNwh5rvirjTEaKlH+xySBgq23
         xaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbjyc/6vqLEWFE0JLAV3s9C1EpmcaDoeH9qzYsPDNeo=;
        b=rQ+gcCzftQMIJuuX3G98ONdhAG4Uv3Eu23o/6NpvND9meW1bKLT462MFH/pZ5qIQyY
         1feXFt/z+755DH7AA3Vs8yuRAh5Ow5P4tWyaXibTD5crCHLFMNpTpoZj6+wrbW+6v10x
         rq5MK43LYNhnAWRzDWtOk7SiAiQ44sqF3lZ8skmTVwz4otbdVB63LMG2c98jO8Mcf8tp
         85hD+Fc5KuEif95osZ4pqfZ4km/SfRVCWxW5hNifDpJGSrJ8S7YVZZRD+lI7J1rMqMK4
         uRWAoJxhDtusAtXRvIJh5AShNYjTZ+O8MmjDS14Lxri/rwgy6uIBJaCXD3luefp/ltqu
         P4Xg==
X-Gm-Message-State: AO0yUKXfNmsixvDGIpRx6WiUmvgWmSCGXjFZXec/ui7QeGCOWE5ibSps
        sfNgBmk9JgAYZstsLfO+XGk/tT3vcGQ=
X-Google-Smtp-Source: AK7set+zWfr+88NzJAKmH64N4RSLqAVjNJjg4uQ0LXN1OhlZh8LQGM9A1XFEEuh4LurfQQ2O6OZ8ew==
X-Received: by 2002:a05:6214:400c:b0:56e:b91f:aea3 with SMTP id kd12-20020a056214400c00b0056eb91faea3mr27029870qvb.48.1677263913557;
        Fri, 24 Feb 2023 10:38:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b198-20020ae9ebcf000000b0071eddd3bebbsm6823224qkg.81.2023.02.24.10.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 10:38:32 -0800 (PST)
Message-ID: <99294bb7-d81b-4031-56b1-b412b4947b69@gmail.com>
Date:   Fri, 24 Feb 2023 10:38:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 21/27] mfd: bcm2835-pm: remove MODULE_LICENSE in
 non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lee Jones <lee@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-22-nick.alcock@oracle.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230224150811.80316-22-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/23 07:08, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

