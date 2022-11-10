Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F541623E96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKJJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKJJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:28:25 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1202DC;
        Thu, 10 Nov 2022 01:28:24 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13b23e29e36so1548516fac.8;
        Thu, 10 Nov 2022 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGO0ip7w97EnTI7AeEZExC1C/s0SPOAF/+gJW/arOas=;
        b=NLICpqWIL0oh8UeRnPS3bbaVWziUjgVrUCmoRKINtKXcM1AYSm0nkGmbakc670hive
         K/WgPCHnPdqo3MvIzNom3wJbJjFCF5zKKdHsdJ3qTnpyHW5xzyUhimFR6GBkivLYBxsW
         eWjIp7AGe/Z8dTjb5qXORiMZ9XG0rttbX+SmO+1JJEfCua1F0bmQ15bp9w7hzr52gwCW
         LSSs+MQx11ItkSKhJOWfX47Lv0G4oOCe06+TpAAfD068lgcm3xt0UxQtiNBqESvVNN2E
         /UX9i93wAoBpo+rAmA5OyW7ymX2U35ISeWH4SG3SGaYo8hBTI1OI4nbVPQqXLEdBvYAQ
         IbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGO0ip7w97EnTI7AeEZExC1C/s0SPOAF/+gJW/arOas=;
        b=3tHLkxLnDuUw7hzOPMBlgRMwRQNXiu6aP3ghd957vuyrXC6p+aQ0nxrIeIDXcB8ae6
         cwmMx2OsN1giwOdEm5JNyX3b+OMA+quKTSlvz8tblGSERRlEMIT3t5fMIqey3n10LEAn
         fxsNDSonsgKjBZvmVzfuLLtIHCkWoqZXOqF4VmOUy3xTUwcQI5i4LY/y4MNF9GwcX7Km
         l58qugynq1a4ZnSD9+mGVJxX+PXvSjdqrH/XmK6I4+09K/TSYKqrElrQBGokXGms9zCd
         IyFASO2cZku3uPAO0kHdSPCNExEE0nTML65veLCQFx5aIKoZmJW3WXr0ow6jS8RwEIci
         eRjA==
X-Gm-Message-State: ACrzQf1E2WuUXk08BOkLfu8a41bLD/sPiXsfj3SzSHSH/K//m/YYPgp5
        e1YI0HjViyY5XSXKSufz4q8K/tQPEOANNt2hWzo=
X-Google-Smtp-Source: AMsMyM5a9kSvD119ASRMT5PLTan+Njl0imIQy40yppsugaLk4qbvFSsFoYojJ1DghWVOk4H6rr/sJ7TfhNoAPaQosZ4=
X-Received: by 2002:a05:6870:350:b0:13b:7165:3ae2 with SMTP id
 n16-20020a056870035000b0013b71653ae2mr44802717oaf.11.1668072503816; Thu, 10
 Nov 2022 01:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20221102155558.1895829-1-dsankouski@gmail.com>
 <20221102155558.1895829-3-dsankouski@gmail.com> <1a8bab07-46c4-1585-45ff-8780c02afd4e@linaro.org>
 <CABTCjFBth=jON-uuMU54cQi3zDcGYtGMbpaKitc1WHx+ciNiRQ@mail.gmail.com> <c0ffd719-f1d6-9a2f-acb0-b777d9758397@linaro.org>
In-Reply-To: <c0ffd719-f1d6-9a2f-acb0-b777d9758397@linaro.org>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Thu, 10 Nov 2022 12:28:12 +0300
Message-ID: <CABTCjFARy+CKsqQM+4pAwKnkP-EeW3p2swzTZzH9j2NpeMnT9Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 7 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 17:33, Krzysz=
tof Kozlowski
<krzysztof.kozlowski@linaro.org>:
>
> On 07/11/2022 15:24, Dzmitry Sankouski wrote:
(...)
> > A lot of warnings for msm8998.dtsi, though. I think it should be fixed
> > in a separate patch series.
>
> Your DTS is not OK and it introduces wrong pinctrl entry, which I
> commented under. It also does not pass test, as I said:
My bad, I'll fix that
>
(...)
>
