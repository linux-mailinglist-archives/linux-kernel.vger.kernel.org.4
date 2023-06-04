Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070C72160F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjFDK12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjFDK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:27:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F57BA3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 03:27:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9745d99cfccso432120166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685874443; x=1688466443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGyIvotUfIBMdSekfw4Xn4d2xdDdkWYiVfVsev9SWoI=;
        b=htkcMOUVuWGuLhTGatJhCckvMtpXU644Opa9IasZcADghKTJUv5SAtoA+sqW8FAAYi
         60RQthfve9A9LmqXr3h1XebgucrahzqBP4YVVvM0T1gfI8M3KU8hvOyI5xY3duCv0EiA
         oSR+zgUtZAD0PBKcf7b9+RaT0lYy0RZBsWOLSG2Dv+CwCDiJGItXm7amER78VAxrwiFC
         pMqcywANOZiPMTFq7Y9MW7/km9kmKEFxuHUidh1KVouRnzaJM0zRil1zk3b9ZT8MJws7
         vQwDuOFKRCdhFkVZ0rUdFV+rbK9jNuCgRdPOctIjs1mvG78WIpoCFMbkF68NQXJai3Co
         +rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685874443; x=1688466443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGyIvotUfIBMdSekfw4Xn4d2xdDdkWYiVfVsev9SWoI=;
        b=E7aZ5T/dipSRAqp66LUk72Jnvn0TSKkWCildfM06XHgh5LjqtmelQhF9GMuotEvbaw
         BkU20pYlFj5YHbWV8G0ZSgtSzMMgXwuH3Msw+AyBn7yqBTxDvDtG23+wyUUX7GOJYgqz
         gFEg4Osl9oIyq9T00q30OaLdGWuphwldE3HbAqW4pu4dlRuiwpqVL0eNDb7uy6Jfmix6
         5Kae3Bus2ypMNOFOnZScKfU4AyqtKbpHgGE8V7Br9H/0thCLAVpjUUNl31ONwTm4CcOq
         alz3+vEXQX7w4Qhfqar8V1mmKpqb5i3bd5BSBD40K65egtRlRcfRfn30APaYi4uDITQo
         ZTOA==
X-Gm-Message-State: AC+VfDwg0G7Rb/+a0pBBAYuPze/K9lElIV2MaNyzgVc5dDZXXOsBaKJd
        hbKMHOF832IgaDKi3FUdpW/hrn/NvUy3iRe+ANw=
X-Google-Smtp-Source: ACHHUZ4/xX59uxUa167JlzpcGJG4EeJTMyLafv9JillZlZILq4DpLfwngZBs28oN65IYsMQwlDIB8w==
X-Received: by 2002:a17:907:70c:b0:96f:7d09:7deb with SMTP id xb12-20020a170907070c00b0096f7d097debmr3680328ejb.69.1685874443625;
        Sun, 04 Jun 2023 03:27:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906111500b00974530bd213sm2953017eja.143.2023.06.04.03.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 03:27:23 -0700 (PDT)
Message-ID: <cf6bbd59-8681-e1a7-16ef-16eb8a7d8a0c@linaro.org>
Date:   Sun, 4 Jun 2023 12:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: document audio of graph port for
 cs42l51
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230531140912.819373-1-olivier.moysan@foss.st.com>
 <20230531140912.819373-3-olivier.moysan@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531140912.819373-3-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 16:09, Olivier Moysan wrote:
> When linking the CS42L51 to another DAI component, according
> to audio graph cards bindings, an OF graph port property is expected
> in the node. Document the port property.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Same comment, please extend the example.

Best regards,
Krzysztof

