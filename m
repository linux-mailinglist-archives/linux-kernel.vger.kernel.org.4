Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493AB6F0200
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbjD0How (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbjD0Hos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:44:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F21FCF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:44:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3047ff3269aso2747037f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682581485; x=1685173485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wgos7Dc6ZtRB5CqatBjKwxP8d1dqbdAv7FeLOlGYKNw=;
        b=BmxjMpnByldPqTSdy43oY0ovKHugK8HCUimbUcORoLL7crB52Ix4rUPYhr/uLToImH
         6INPDN3ja5cNIGhL4gzUT89Ge4V0h16Te29Xr0VBfspOyPxK1o7fInTj8Z5qmP57a2HD
         25qzJ7nm72Qp7AdvpUnwLjZWPPK2mJo5Nxa7wOtmULgeoX+kWHmwHxdReDdPs9jYVQZd
         qjtFURBZIDtr0GFTlKSg9xaIk0pIDHgInpmniKK0/LFandUtrrj/ZCQCSBMHlZ5Nfav+
         Uen5KlFgF6BaQ3hSPGgLdeqBoROkaCeDkNZ6ACVzHbO2KWVECEMEkdVuAdqR9dg5hHij
         6AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682581485; x=1685173485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgos7Dc6ZtRB5CqatBjKwxP8d1dqbdAv7FeLOlGYKNw=;
        b=XcicqGtK8Cq5+8SpHy3GW4SS08AyFTzi3QsaA7rr4S1tUHnRjH15iB0xlw5ivnQAMt
         U0yJ6QCNaQhdmfxim5wbeOzrpkl5PM+Kk1QNS2F/smtAHOBQxfsEPRvpRdHeVors0k6a
         wc9quB2Mt12oOxDd5pe9IXHyjLNmSXkL/CcyMV0sC55kNI+o+5FZc2g9KRfuSvfInz0a
         SOZ9PvkkwEiXMdNcbmMAueo2aI1BNO1P4r8Kv3uxS6Wly3MBSZvI5zTbfKJPT3nQMZsz
         clfR3ZjHXBDxGPdf1Gs1I+rb+fS2MsuKH/dsAmdzaq2BuA1A2sAx2OVOaIgFtMJQxk6Z
         6H6A==
X-Gm-Message-State: AC+VfDxTEF4jDlP7iAEhx/hOSID87vSEd9r550kos+TY421IxkbD0vsH
        ILFblMwGBedE6+B0M6uQ7LrhF7rtyR1TBfimYMgupnDi
X-Google-Smtp-Source: ACHHUZ7clC9lHO6qCWgIapSvBewpEliPGdkX2yhRFihuNhqB9QPKsLBTy/TfC2yLxOd69QYD201CtQ==
X-Received: by 2002:a05:6000:11c6:b0:2e6:bff9:2634 with SMTP id i6-20020a05600011c600b002e6bff92634mr482027wrx.56.1682581485593;
        Thu, 27 Apr 2023 00:44:45 -0700 (PDT)
Received: from [172.23.3.48] ([195.167.132.10])
        by smtp.googlemail.com with ESMTPSA id y4-20020adffa44000000b002f013fb708fsm17980503wrr.4.2023.04.27.00.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 00:44:45 -0700 (PDT)
Message-ID: <0cddf889-c926-ad89-7a17-ea1c0060148b@linaro.org>
Date:   Thu, 27 Apr 2023 09:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] thermal: intel: menlow: Get rid of this driver
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>
References: <2704255.mvXUDI8C0e@kreacher>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2704255.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 18:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> According to my information, there are no active users of this driver in
> the field.
> 
> Moreover, it does some really questionable things and gets in the way of
> thermal core improvements, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

