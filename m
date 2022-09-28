Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9344F5ED1C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiI1AWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiI1AVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:21:39 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4410D67B;
        Tue, 27 Sep 2022 17:21:33 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-131886d366cso3768015fac.10;
        Tue, 27 Sep 2022 17:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nWYjSiXscG4vvx8iE3jYjE8WTRUUi4M5tMYmkFSaUpw=;
        b=23XzIwWuE8SwDPxUlR7qyN/R8qc0bu48yvJ5u/CQsseckTGIarJ9i5YNyREhj0I/nn
         7/Zohfkfse6hUSNXT1NalTfpt+8JfSOXJgidAjqkcSAxdnAGHl3Bk4o2JCiZXR4JRZMx
         0AGK9yUwJyLQ+b37gabXziojZGs7PeLz2R1fwYsBkkDFCY3aE8Wc8eMBuNs3tztCON+O
         kXBFx2jsqzeM/vZKkYWY5QAL+2A6uciMPrCZ8OLDtFj43HQjw29zl9Eb76jOmzNkD0So
         5LWgAo/w6/opZhdg3XZftJLfnUqndu7vk9z6s7G7hDL7RYRCHaNgQNQ2VHc8Y8luoZp+
         sG/g==
X-Gm-Message-State: ACrzQf0mBc2d1RvZIaXbxqKoGJkDvB3cAXD9DcFbLEZq0PMI6x9hvwxn
        7Wu9B5fZDOToKKsb4glx/w==
X-Google-Smtp-Source: AMsMyM4cdnbf0SIkkgfVCjG2LZ3Rnp7gIgebarkdvhhsSDZ5duNCU/k1SnX0yO/kzGxckz5cIfBmgQ==
X-Received: by 2002:a05:6871:203:b0:127:496c:3e5b with SMTP id t3-20020a056871020300b00127496c3e5bmr3702134oad.183.1664324492850;
        Tue, 27 Sep 2022 17:21:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c15-20020a544e8f000000b00344a22e71a9sm1236990oiy.9.2022.09.27.17.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:21:32 -0700 (PDT)
Received: (nullmailer pid 2692663 invoked by uid 1000);
        Wed, 28 Sep 2022 00:21:31 -0000
Date:   Tue, 27 Sep 2022 19:21:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 25/34] dt-bindings: pinctrl: qcom,mdm9607: fix
 indentation in example
Message-ID: <20220928002131.GA2692580-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-26-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-26-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:53 +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
