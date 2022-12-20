Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375776526A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLTSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiLTSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:55:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBAC1ADB4;
        Tue, 20 Dec 2022 10:55:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so13092290pjj.4;
        Tue, 20 Dec 2022 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXGgkWFMp3OYd+RGGfsh3gEVvYrFeFbPd9DXXHvfsjQ=;
        b=ZgsnDg1f1DNDu3MgDBR3XN53JFItQCKtWD8HtQlnIwzB98ZfS/XDhuiOZhSBOK8Uay
         ezFCq7qaaQO10tN6Xwww3ps4dqqV38QWRObXkZ/yV2ohMfNY2LRHuAGJORJpGji9l0eM
         orua+wVlR76QibMP+A8uEVAmOCvAmasYP7nWm24tEL8sMtrwwZCh1k9G0+OkN1nHqUs0
         ekofGjdiIOnq+1HECH/llMXhhVbnsfjBKdjiMvD/OaFYSnsz+83HRMwP+oFvOH2zau4n
         BYimmUK2eY0ObMzfbVtoAeb0wXuhK7Dm8j99AIL17uCULJ6o18rHf4dt/aR4BA0AKK0H
         v8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXGgkWFMp3OYd+RGGfsh3gEVvYrFeFbPd9DXXHvfsjQ=;
        b=lWE7Aa6ptt9P0//U2dmodtfL62yeiF4+gpwGkpZFoqumKxRIvFVLuW3Wk5RjPReqkw
         R65dhvbeQdAWPy5gCehICywW6ccIYLiwS9UbT4by8+hqFrMW0z71uHD6WN8SN/C9tpAL
         4JGptogtX8P3dyOk+nnf/enTQQ6fEVEcqpsnxpJStibrddOcMIAYOqwvDmOLuSka7luR
         LB/6vk+zbZ+hlz6saM0N1JslgIZBeKehhep4kJ0scm3b/AGNh3z8PZ+ews4X6iXwKuWJ
         qeVOCt84LOC9t2Tt8oOlx4kdp3cy9jYVO804zllgzqaSvQ+cL3iacGgxWA+7dm0sbV8V
         +8KQ==
X-Gm-Message-State: AFqh2kpBtzJVOSIFgvS8JInbSdyeNQbxjnaqADrb3Dj7QOFbfwRZGK80
        uxmT+9U6P9jKnQ8ZttGVgDQ=
X-Google-Smtp-Source: AMrXdXuu1a9NYzQV1O5vigsN0o5UqEJeUN2vzKdV1ann8aOQ2vVRrmffGmZ7gpynQ7wpBZc6VC/EIQ==
X-Received: by 2002:a17:902:7613:b0:18f:9b13:5fb9 with SMTP id k19-20020a170902761300b0018f9b135fb9mr13274425pll.60.1671562531357;
        Tue, 20 Dec 2022 10:55:31 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7206:404e:4820:d175])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090332d200b00188ef3ea2b6sm9700453plr.262.2022.12.20.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:55:30 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:55:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Eric Anholt <eric@anholt.net>, linux-input@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: raspberrypi-ts: Fix refcount leak in rpi_ts_probe
Message-ID: <Y6IFHzJOM4qDyoWk@google.com>
References: <20221220115246.1522054-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220115246.1522054-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:52:43PM +0400, Miaoqian Lin wrote:
> rpi_firmware_get() take reference, we need to release it in error paths
> as well. Add missing rpi_firmware_put() in the error handling to fix it.

Hmm, it used not to take a reference, but now it does... OK.

But I see there is devm_rpi_firmware_get() variant, we should be using
it instead of mixing up manual and devm-controller resources to ensure
proper release order.

Thanks.

-- 
Dmitry
