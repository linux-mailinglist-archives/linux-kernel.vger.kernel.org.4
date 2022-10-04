Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91805F3ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 03:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJDBAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 21:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJDBAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 21:00:17 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1529418B06;
        Mon,  3 Oct 2022 18:00:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q11so5615123ilj.10;
        Mon, 03 Oct 2022 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0tva2K0tHUkG42UQWnBxCh+P24hECHlcxOKX4Bb++qU=;
        b=ExWgExUiDb6QFAtTwIvjOc8KnN5myHDVqsggPiBii8Nmo1jgZZgyRa+HKoqPszkNp3
         zfNwXZ5yWw/Q+VpgXnyF0y9m8B9yD4d3all3icEdVkrWBGroH3ZWO1pwz9ZSZMIoM91X
         5ly4+xBfBbun18CSu/Ylr9M3SmeABXyNsa9f3DyQjfHKt2fOkJiIwlAZbLDyxYC8AwNa
         rca9503SWu4VY1aQt+VzddIhgmtKfRsFl+XhIzFPPf4CTBmFdOHM8oCyN0fwmQzxteEu
         Rx6/SRydxz8NsDAvztQVjz/DXq6wlv78uR6W4sOZAmCX8PKqiaLKuSXPeOkVDOc61Pzb
         tCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0tva2K0tHUkG42UQWnBxCh+P24hECHlcxOKX4Bb++qU=;
        b=ugsOCDiIiss9ds4vOq8vcM1XUuqF4YQgEctstdEJyR8G6GrwEjfE5aal/M+C0naEgO
         KPQuxXVCAVxtcAbNTWWsys8WGRTqnHC78wpRBwHMDQnleQk+VX7BZX6G+WHKraQn/LTW
         fHUafgXMWRRgXxpd0RunHIb/ZqPEEJxtgJJ+s0YoFiXNpvChfJBtbYJ98lr6CEaZHElj
         31F8D39gLg0SsnJ4jc9bxOujyEsObNgJ1HLp7lQXwbec84jT7MG7dXkcA3TbfJvgABUP
         K1isrCsbv6bgHHn9HHA1xhB5DtuIVwFa67yQ4WJ8oAgyr0MCV59AmaNnwE2MU/ilQsGL
         ZVSg==
X-Gm-Message-State: ACrzQf3A+LYwDsE5eDSECpX/FfJeeIyun2rsv60z7rY7/1rCFOpYBGuv
        t+Kcx2q/x+lZQixmraNPkuz7+g+GigvvqQ==
X-Google-Smtp-Source: AMsMyM7DTHQhFTLW0V5Ne91vyr730hCr6Vx61hjoqtP9LrmnDzXok8puNmUFV6C0fgd2G094e6VLIw==
X-Received: by 2002:a05:6e02:16c9:b0:2f9:7a81:d905 with SMTP id 9-20020a056e0216c900b002f97a81d905mr6410585ilx.36.1664845214272;
        Mon, 03 Oct 2022 18:00:14 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id u16-20020a056e02111000b002f1a7929d67sm4334526ilk.72.2022.10.03.18.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 18:00:13 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 3/3] pinctrl: qcom: add sdm670 pinctrl
Date:   Mon,  3 Oct 2022 21:00:10 -0400
Message-Id: <20221004010010.34499-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004002333.g5yfjx6lol3pmc23@baldur>
References: <20221001210725.60967-1-mailingradian@gmail.com> <20221001210725.60967-4-mailingradian@gmail.com> <20221004002333.g5yfjx6lol3pmc23@baldur>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 01, 2022 at 05:07:25PM -0400, Richard Acayan wrote:
> > The Snapdragon 670 has a Top-Level Mode Multiplexer (TLMM) for various
> > features. Add a driver to support it.
> > 
> > Link: https://android.googlesource.com/kernel/msm/+/de5a12173c7fa6d65bedee9ad36af55b2dbfeb36%5E%21/#F6
> > Link: https://android.googlesource.com/kernel/msm/+/04f083156d9b9f3bfcf204c1c6da88632fbb3863%5E%21/#F22
> > Link: https://android.googlesource.com/kernel/msm/+/54837652e3400ecc63ccc78b2193faf4f349a32e%5E%21/#F0
> > Link: https://android.googlesource.com/kernel/msm/+/f0409b07174ceca217f8b7fd255418feff06092d%5E%21/#F0
> > Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> 
> Pending the question about overriding reserved_gpios, the rest of this
> patch looks good.

Except for these somewhat inconsistent lines:

	static const char * const qdss_groups[] = {
		"gpio13", "gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19",
		"gpio20", "gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26",
		"gpio27", "gpio28", "gpio29", "gpio30", "gpio41", "gpio42", "gpio43",
		"gpio44", "gpio75", "gpio76", "gpio77", "gpio79", "gpio80", "gpio93",
		"gpio117", "gpio118", "gpio119", "gpio120", "gpio121", "gpio122",
		"gpio123", "gpio124",
	};

	static const char * const phase_flag_groups[] = {
		"gpio29",
		"gpio30",
		"gpio52",
		"gpio53",
		"gpio54",
		"gpio55",
		"gpio56",
		"gpio57",
		"gpio75",
		"gpio76",
		"gpio77",
		"gpio89",
		"gpio90",
		"gpio96",
		"gpio99",
		"gpio100",
		"gpio101",
		"gpio137",
		"gpio138",
		"gpio139",
		"gpio140",
		"gpio141",
		"gpio142",
		"gpio143",
	};

It should be this, will post tomorrow:

	static const char * const phase_flag_groups[] = {
		"gpio29", "gpio30", "gpio52", "gpio53", "gpio54", "gpio55", "gpio56",
		"gpio57", "gpio75", "gpio76", "gpio77", "gpio89", "gpio90", "gpio96",
		"gpio99", "gpio100", "gpio101", "gpio137", "gpio138", "gpio139",
		"gpio140", "gpio141", "gpio142", "gpio143",
	};

> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Assuming this isn't invalidated by the above change.

> 
> Regards,
> Bjorn
