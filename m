Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE66E6B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDRRzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDRRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:55:11 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4EC672;
        Tue, 18 Apr 2023 10:55:08 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6a5f852002dso601792a34.3;
        Tue, 18 Apr 2023 10:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840507; x=1684432507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAimH9MZlv+g+G8GpQ4zpWQoJtVrlg5Iosr9QYS4Nak=;
        b=GEtHRkiFLsoyus0dymVrSv9xDthO/vNz7lH2eu+4OqFmvFojo8Xs3fVoDZE+Ot7XUR
         Zyhrz8GmX+0aE21MdnmuH1+GhXMVYAQ2JZHGnWp/w0TOSBoE6Uf8iOrUo2+Tmy6rcCXW
         k3y4Gjm8bA864KmWP+uUi8EuWWmdr0slWhu12WqjYgQ2cnkkpPx1j0sUsKdr0ouQf99a
         bsosowGKBJx4trdVAnNolgiF+93N3ZHJ2qPEaSFBqYMTYmjvu5AcWu/+Du9gumOBUJJ+
         kia64Jno37NmimwDSJ5X3CvYFkUkulyuf4N686bpNJkANFhAtniZPCS/V17a95PhyR79
         JckA==
X-Gm-Message-State: AAQBX9d8XW94RgdmnK+FhvCMaqvPywcvzBJG5T4qpXLuoqLYmEuN+mEY
        jOMBVEALp+aHpNpKlZ7pIg==
X-Google-Smtp-Source: AKy350b+0Slg4uWLcLoeXxGzP5rqrZkZWwU3anJysWfDccBq3R0Kzv3/OD8DE87GSBVKt/ynFMiNjQ==
X-Received: by 2002:a05:6830:1e3c:b0:6a1:535f:b095 with SMTP id t28-20020a0568301e3c00b006a1535fb095mr1507786otr.18.1681840507309;
        Tue, 18 Apr 2023 10:55:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p9-20020a056830130900b00684152e9ff2sm553219otq.0.2023.04.18.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:55:06 -0700 (PDT)
Received: (nullmailer pid 2044769 invoked by uid 1000);
        Tue, 18 Apr 2023 17:55:05 -0000
Date:   Tue, 18 Apr 2023 12:55:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: qcom-pdc: add
 compatible for sa8775p
Message-ID: <20230418175505.GA2044093-robh@kernel.org>
References: <20230417094635.302344-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417094635.302344-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:46:35AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for the Power Domain Controller on SA8775p platforms.
> Increase the number of PDC pin mappings.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v1 -> v2:
> - increase maxItems to a value that covers all other users of this schema and
>   leaves some margin on top of that

Looks like v4 to me... Anyways, it's applied.
