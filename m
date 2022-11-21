Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E496D6329B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiKUQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKUQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:36:44 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F448CEB89
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:36:37 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id q13so440832ild.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cp2GUaJ4Q+axhxXC6f2KvKPg06VkSSSruHyJ/Tswgd0=;
        b=CK+teSe8L6CR9pYTU6D/tJpcZa1FXXOXPrRcYCLyEdQr0jhYE1AlxU8IUbtfZON5IP
         jJdiaaYDssxtAdo18KG8wC2QzpNZS8LIHP9DwQ/xg1UDkEUn6Kh4qihynbX6tXY3KcBi
         UWA7VDSgg1Y9s2n7P3flwLNuh0PhDWPVm/HuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp2GUaJ4Q+axhxXC6f2KvKPg06VkSSSruHyJ/Tswgd0=;
        b=2SsuLvdrjR7s1uJhZGB0L+jGHY4XAyL83Vmm4N07cdDaBFX4ASGI168FAeFTPeBN6b
         l1SrdUqAGGK4Cj+6HB88F9VMLgOZukYAa7Ysozsco6bjRYPHfTmai7L9cg+mUYhtl4C0
         EMdXvDlXrfCFB8hozDXdzS+nwui79/+ilpHgyuIImrefZPasDzKGJA84C+mXIU2cnL1V
         Nq79NKHGipIauj0027DYv8OYODV6mxLD1yfoTRdMCTXNLZUcpY7AUvj2jlc5jGdywI/S
         D0Jx+5yD9Pv7dFPKD4CTgWYhc66pQguwtwszgNyspcNqtzHTz2o8sm2z9yPy/H8FQ2S8
         QaIQ==
X-Gm-Message-State: ANoB5pm9UTmPZg+n3HoM/MyY1I6BnD0PajzAfqL+0y1M3mPdPZDdVWcT
        QIfg5lYWfgPLwHvz7leLu6BsXQ==
X-Google-Smtp-Source: AA0mqf4FMjBrQHyDsYVl/MrxmyHkHgvXCKjaxSVSllVw7TdnFWn/bEbZtu13JPJTQBiYzVj6VXTORw==
X-Received: by 2002:a92:d089:0:b0:302:52b7:a5cb with SMTP id h9-20020a92d089000000b0030252b7a5cbmr649867ilh.241.1669048596896;
        Mon, 21 Nov 2022 08:36:36 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id b24-20020a5d8918000000b0069e1bcbddaesm4445716ion.16.2022.11.21.08.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 08:36:36 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:36:35 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Message-ID: <Y3upE5FfSW+jgQXT@google.com>
References: <20221121043437.21925-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121043437.21925-1-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:04:36AM +0530, Rajendra Nayak wrote:
> Add compatibles for the Pro SKU of the sc7280 CRD boards
> which come with a Pro variant of the qcard.
> The Pro qcard variant has smps9 from pm8350c ganged up with
> smps7 and smps8.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
