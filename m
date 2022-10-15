Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF815FFA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJOMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJOMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 08:41:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F05A52DD8;
        Sat, 15 Oct 2022 05:41:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so7076830pjf.5;
        Sat, 15 Oct 2022 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+ScK9lEaYyTa9Kg//6GLnf7yqmnFfT/KA+ti0bjqIo=;
        b=SwQGmFrLXb7G5MjAgEK8vkizoeofI2QKlXGd60Ot9w1dM6OiO4oIFk51QbvAS+7KAJ
         IQsjhZxWuQL0hQnaf4tmBXOYYIt7e8UVZJMTMqwalq9nJ6/fZSE06LVxWMHJI1wdEihi
         6Bi5xqY2HrmmQJhksIM1GAMaAnNWhWsc7k3+9MSVbP1nnc0j3IjnOoNvydlqSCRp4BzV
         o+yzrOSTNLgTimjlqn797BMrAJe4hbfSBg/LMY3Bhr/UcKqnVI8zaW3jjXti+gn00hcb
         rPI9/1HUrGOzRfiFVo83/GNFOaTBlyPrfcH2JtcczHkxHjfVPZ3avryijWoYziAuUokF
         pZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+ScK9lEaYyTa9Kg//6GLnf7yqmnFfT/KA+ti0bjqIo=;
        b=1NogyRP++BJYQAA+3vjAQg/VQyBHX7RtvLOJZeR92C9CBnkz3aZL1tM4U8nluueQDC
         l3d8jNfQTdujoAwd+cTKXgW/BHkVzIGBXJPOXYLfkWsWEGhrWN+8CZSHH8pk9q08esdw
         kSyO9UDVvF3B4BIvGeoTUeO7LTR/6S7cDs8swK5xVOQUKgERcPQLKpMEzy/dHvVV6oxG
         92/1rnsxFR5xFOE5nBsPFYZ0omAu0jTBuG5Za2htKVex8VyHj0kwXONgNrB3IfXJkIIR
         kkNSlg7UJMmTT2au5BRoWsHOxSJqMYaFPhsrFUENu8WkOYmZc2blD25IoVCFjlMkHU3C
         k0hg==
X-Gm-Message-State: ACrzQf0ts0dHoWncLiQ3otZAoeW9rlaU53pth2p+WvvvgwU0h/rZ0Hjr
        UM0lIB9SMzsEHDUqBZ66TIfDGhGUp6U=
X-Google-Smtp-Source: AMsMyM6hiqnyVZ16tv07wRgTh/unK+JUYzbF+1BgoTsuqyBy7SjAubEFhX/J6N3WcxTlbbAb8bkPBQ==
X-Received: by 2002:a17:902:c103:b0:17f:da5:35c2 with SMTP id 3-20020a170902c10300b0017f0da535c2mr2810308pli.20.1665837698822;
        Sat, 15 Oct 2022 05:41:38 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-19.three.co.id. [116.206.28.19])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902e74d00b0017854cee6ebsm3389345plf.72.2022.10.15.05.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 05:41:38 -0700 (PDT)
Message-ID: <2f9f1cab-1053-db07-68aa-724741356fbb@gmail.com>
Date:   Sat, 15 Oct 2022 19:41:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 0/6] docs: Improvements to our HTML output
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221013172918.846856-1-corbet@lwn.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221013172918.846856-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 00:29, Jonathan Corbet wrote:
> Sphinx has a theming mechanism for HTML rendering.  Since the kernel's
> adoption of Sphinx, we have been using the "Read The Docs" theme — a choice
> made in a bit of a hurry to have *something* while figuring out the rest.
> RTD is OK, but it is not hugely attractive, requires the installation of an
> extra package, and does not observe all of the Sphinx configuration
> parameters.  Among other things, that makes it hard to put reasonable
> contents into the left column in the HTML output.
> 
> The Alabaster theme is the default for Sphinx installations, and is bundled
> with Sphinx itself.  It has (IMO) nicer output and gives us the control
> that we need.
> 

I don't see how switching theme will solve the left column problem. Are
there any customizations on that column that are planned?

-- 
An old man doll... just what I always wanted! - Clara

