Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1B6C00CC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCSLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCSLXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:23:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CAB211E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:23:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so36467177edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679225023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uhjd68zfF5UiWTfwOfNThe6SqbXCr8qYgQuqxBosLCQ=;
        b=y6pV4LwjyTHZWDZScr3dOeB0HT/Oexu7LE0PgThaO6GiZE//I7wPbu+Az3u670gqRL
         Z6qQwJuwyfylluWvYqT0jfmpST/4LaYuWZJw2Blbejxm9kGDP2fgTKzW/lG0jZtGp2bF
         yXbKUvSG8CN/vTOSKaJU+SktSLYqChOUkZFsARTUPTo9GTaA6kSIl1ua5mvNByk1lA6D
         S5F3U4FLPVb/g9q0WT10r71JoJHV1YbsBgH67CI5w1D03vBETuFJ7hJdwc1eEWR8N0CG
         Dgzf4BRYZjD9iQ/nPVr0d8wVBtV1aohdPS9bG0epM++7muuhCut/O9z2+itOft7TQrdd
         9bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679225023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhjd68zfF5UiWTfwOfNThe6SqbXCr8qYgQuqxBosLCQ=;
        b=7la5ORVSU52ldUptHIF4gPu7xItdiU101++MQT8101WmdXCjCsGykkrANy6iliXfSc
         qDF/IksiE8BOhixcNE3lDMeIlPbLqA4m6ak9ywFjbEOjpBgORFpQh/3FgGYnLJXNqWq7
         LvtmRLWJg4J0LqpH3ahjBM//2+JCRz+NwUIEKNRqKLxmlRC6y2/Nolcw5h3E2H3StwsW
         zLwQztlklwrLPx7+ZyQj6/+b76+N7QE9plsaM5SFTlOF9KYoTqaUCy+7lGJg+kL28dzO
         qanHzYWiQDBPBvlhucOXVAvDNQTcOKY8VydIV4keuHJbMnMooF/VlpgqOE+xhGSKdJTE
         VKUg==
X-Gm-Message-State: AO0yUKVgLUfj2/Je+EL+0CYJj48ylFjldsep3z3DrkwKa/zFZBj+sUfz
        fYR56IZRc5PPnmHAjmIlQGipKQ==
X-Google-Smtp-Source: AK7set9DH7t9vbYttxzDn2t+uwPKGFFb6IpYIdpWB85V46GlocLw+bx1xwjNNTedM94sH/tCTCze1w==
X-Received: by 2002:aa7:d744:0:b0:4fd:2b05:aa2 with SMTP id a4-20020aa7d744000000b004fd2b050aa2mr9563909eds.42.1679225023065;
        Sun, 19 Mar 2023 04:23:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id t17-20020a508d51000000b004fa012332ecsm3416669edt.1.2023.03.19.04.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:23:42 -0700 (PDT)
Message-ID: <64d0dffd-a5ce-4667-9d56-1c109ec73866@linaro.org>
Date:   Sun, 19 Mar 2023 12:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v11 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhananjay Vilasrao Kangude <dkangude@cadence.com>,
        Anindita Das <dasa@cadence.com>,
        Yuan Zhao <yuanzhao@cadence.com>,
        Milind Parab <mparab@cadence.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230317075120.506267-1-a-verma1@ti.com>
 <20230317075120.506267-2-a-verma1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317075120.506267-2-a-verma1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 08:51, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Add num-lanes schema checks based on compatible string on available lanes
> for that platform.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

