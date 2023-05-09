Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83656FBEF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjEIGD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjEIGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:03:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAA93F8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:03:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965d73eb65fso800385366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683612232; x=1686204232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsH7IuR350AY6M/GUxVaHLhDrB8BkW+KGhz1o7Oe7uI=;
        b=YmDOiJAItVT+wtApO9yjWYjhVIedJ0W7bXXiC2bAkdbPbQ1iiidB+VxmzOg7dJldDV
         8AY35L2QaQw5m9vZH6RAlE6jIKRNXbLyhdHwW+1LG07iFJ+BfsCyxOJ+H9e9VkKodJ/1
         KWczbb+kd3b7mG/eSDdyqcrB+YfTH1VEY/Y8E9LZUPuU6sKyXn2DITq5PVQt+7oqoiKr
         k/e7T6lf/8aTI4uc0mY83UTuyFwaFqdfwPyhe9XXhCnLGgaXgA6puMExS7JdyZBXCB+e
         QlcRSKoBlpQ19bk9YwfzjSIV85y8fEaEwNbIV5QR310O8qIW2rOG79wk8sHt4P6rGCve
         C+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683612232; x=1686204232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsH7IuR350AY6M/GUxVaHLhDrB8BkW+KGhz1o7Oe7uI=;
        b=hNvLSgLpCk4rHMt2bOTYHq+pIOxnUAYGRykmC0DajYF0TRhFWocZc4isxF6qAfHWFt
         0mn7P2QT6S67mmq4EXLY2wn99FttPrkAWOZ6KHu2dxvRdzD8xljNeGey8npoTNtB3cjF
         cIH+XRBM+XkDPk26nL47lHtqd5KvKz68pjhAhgbbnZeOt8EW44UpPiXdAwIDmWY1Vxd0
         vXQvCtbtmVr3IVY7PGCl3OTlIGB8SVQVpPMVQMdomrjclAYUIfcB3f3A5+PJ+ppGWlL5
         EuamRNpq8WJcio1fQ2D3X/wfrJJCYd+PhT5n7mimx6qy1nhrqiedpOJbI87l0Ro5smAt
         YTYQ==
X-Gm-Message-State: AC+VfDwCfOwcBivjFbJQ07fO9bQzyMMwmlJApT6GJ4suJ1n+1DM13Zpz
        KtFjVRxMWGFevk5VXjQxi4DY+w==
X-Google-Smtp-Source: ACHHUZ6dko7UQK4ljbG2TATUGOWdXNz0sunLBpu2fJgbvSmMNLTGVQ3iFPEFmlgr0pRd5su6qdB22g==
X-Received: by 2002:a17:907:3686:b0:94f:2852:1d2b with SMTP id bi6-20020a170907368600b0094f28521d2bmr10345577ejc.72.1683612232355;
        Mon, 08 May 2023 23:03:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id ka11-20020a170907990b00b0096602a5ab25sm874194ejc.92.2023.05.08.23.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:03:51 -0700 (PDT)
Message-ID: <1322cbac-784a-760e-cb20-6ea2dbb1abe6@linaro.org>
Date:   Tue, 9 May 2023 08:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH fixes] dt-bindings: PCI: fsl,imx6q: fix assigned-clocks
 warning
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508213537.GA1193015@bhelgaas>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508213537.GA1193015@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 23:35, Bjorn Helgaas wrote:
> On Mon, May 08, 2023 at 09:18:37AM +0200, Krzysztof Kozlowski wrote:
>> assigned-clocks are a dependency of clocks, however the dtschema has
>> limitation and expects clocks to be present in the binding using
>> assigned-clocks, not in other referenced bindings.  The clocks were
>> defined in common fsl,imx6q-pcie-common.yaml, which is referenced by fsl,imx6q-pcie-ep.yaml.  The fsl,imx6q-pcie-ep.yaml used assigned-clocks thus leading to warnings:
> 
> Weirdly long line here.  I think it's good to preserve longs lines in
> warnings and error messages themselves, but in the normal text it
> looks like an oversight.

Thanks, somehow I missed it. I fixed it and applied. Let me know if you
would prefer to take it.

Best regards,
Krzysztof

