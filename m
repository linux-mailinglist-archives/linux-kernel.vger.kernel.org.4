Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2A6A23C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBXV0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjBXV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:26:27 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C466F435;
        Fri, 24 Feb 2023 13:26:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g12so306031pfi.0;
        Fri, 24 Feb 2023 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5yhkktVaVGYkk/cuH+RN6eD59bu5PZOR28I2frvfH8=;
        b=VkOQFJ8xlBzwnZbxQH+oouRag+3X3CaYmPLwCYFXBSCRIlvo5BWfDEvGcUkOeGl9GI
         9PU2R4G9FNUMe21IfrdFgOziFfSCSM9SIdglUv4tw2Oue7OdNIfdf8bQmm5E6yOYJoo4
         1P2BegwaqtZKFaYYe5QNZB+fHgMS07y7LvxHTg9Pv+GRhBl0uzDVBOIH8YzIca2kFBsr
         5QM6gnZb+oLl/eULdIzux/MPCrMyg1RtmCTMjpJWU6PdCtAAa2eafOyPlq8S3vt6V/W5
         qSs+4znoqMx6+9W/5rNiQkmlwOaJbaBdIsaHvorO01gymiDb6DMqEu45JEjw1dLLYykk
         XQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5yhkktVaVGYkk/cuH+RN6eD59bu5PZOR28I2frvfH8=;
        b=zo4UZ6iJcCjkuviOcFbnwd+Vs2Gq+Ip/Z6e8h40wLM+CiFdmZoA7uC5/GOlHkdolRS
         iln0gZ0IFPII9bFEyTcxqvAm7DkbNpWtOoq8Gxdwg+x5eVCAhMFSLgtfePsmt446nibv
         Ya+u/AG9N1uegLj6l+Uk3suVafwlolzn3Ocg3RQ15F9Av/bCQrSbNRO7u50NV7f7rG0T
         gNzvIp0INffNieUsUGAAn2ElfHWvNFz3k8MJEPJaW5g5g06i3s8f0tpsJ8EhZGVBVvB6
         YV5VyqogJ67E6EvRX8PIkArjj7IR+Q/a6Ifbhgw34ut5Y5Ddoc+JPO8lW+bB+zzY56Ln
         8WMw==
X-Gm-Message-State: AO0yUKW8BAygw1Dq36cBQPbpkwtTq/XfVGkiDOJBmFA2IClnQK/v+IeG
        hvjRDX+nhSVMz1rBTUIfQvE=
X-Google-Smtp-Source: AK7set++cMvf4ybFhV3Dqm+rgAV0CG1xF6Bbtk0odqKF6J5L83Fyp633n1452sUWkFMNvDpYgKXJmg==
X-Received: by 2002:aa7:9466:0:b0:5a9:c7bb:4d94 with SMTP id t6-20020aa79466000000b005a9c7bb4d94mr16857757pfq.33.1677273985388;
        Fri, 24 Feb 2023 13:26:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y6-20020aa78046000000b005df065ebd5esm2941449pfm.209.2023.02.24.13.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:26:24 -0800 (PST)
Message-ID: <c912fa13-bb62-344d-ef2a-a51514bd953f@gmail.com>
Date:   Fri, 24 Feb 2023 13:26:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/27] kbuild, soc: bcm: bcm2835-power: remove
 MODULE_LICENSE in non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-6-nick.alcock@oracle.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230222121453.91915-6-nick.alcock@oracle.com>
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

On 2/22/23 04:14, Nick Alcock wrote:
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
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org

Applied to drivers/next (cannot push right now due to some firewall 
issue). Thanks!
-- 
Florian

