Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC25B3CE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIIQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIIQXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:23:53 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489A135D7B;
        Fri,  9 Sep 2022 09:23:52 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11e9a7135easo5186503fac.6;
        Fri, 09 Sep 2022 09:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eiTf3RNVyLMPia/zK4tbG0TfXa2i6tVE5ZYfIN76N6g=;
        b=Zyn1sMJ8inSvKDka+EaXkaxRKiRP4JxQM34vpqIvxv4AumnnNw8hDb3Vka0XPNmBaM
         n51kw+tjhziUArnio7NnHx0tBtipWJFHMrffl+29RjUPTYvKNgoIXRJnkHp2Fm4jZxLw
         Qe1lMFP2Zwd7ag3xp9L7Zwqu25hjg0GFTvZmRUytdlPwRsCrJi7E23mbBNv2NIVdRkSt
         Xv8H/JpFK7UsgUmu34G5t2JqxwQ/ZXOdE0FYzJm93Tll11xgacx/7Q8aNshHqjGHOmVw
         zMw/EB9jsE4m0hxn8MsKQeoJE34peqY8Q2KchuU/CDRN2hYmtCCAW7V/IKZ9e3s0aytT
         XTtA==
X-Gm-Message-State: ACgBeo2M2aiha0QZQDwbPs4bCk8wRMZltuzy3kA3HgewjsYxvst3Lsn3
        StoFHYLSx4uZCmlRsD4ExYgTJ/5uJg==
X-Google-Smtp-Source: AA6agR59Hs6nxAtxrxwCcU4nAy3Umw7VOf/DpiySuw+tRzF34IFc78QLc+kOlh38oDl2cjE+5Zyz6g==
X-Received: by 2002:a05:6808:15a0:b0:34b:aeb8:9cb9 with SMTP id t32-20020a05680815a000b0034baeb89cb9mr3954830oiw.67.1662740632082;
        Fri, 09 Sep 2022 09:23:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w10-20020a056870e2ca00b0010efb044e37sm572867oad.27.2022.09.09.09.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:23:51 -0700 (PDT)
Received: (nullmailer pid 1489668 invoked by uid 1000);
        Fri, 09 Sep 2022 16:23:51 -0000
Date:   Fri, 9 Sep 2022 11:23:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/7] dt-bindings: remoteproc/misc/qcom: stricten SMD/GLINK
Message-ID: <20220909162351.GA1455181-robh@kernel.org>
References: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:53:56PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> This depends on qcom,fastrpc.yaml conversion in Rob's tree, therefore
> everything should go the same way, I think.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (7):
>   dt-bindings: misc: qcom,fastrpc: correct qcom,nsessions name
>   dt-bindings: misc: qcom,fastrpc: add compute iommus
>   dt-bindings: misc: qcom,fastrpc: restrict channel names
>   dt-bindings: misc: qcom,fastrpc: correct example for GLINK edge
>   dt-bindings: remoteproc: qcom,glink-edge: require channels in children
>   dt-bindings: soc: qcom: smd: restrict child name to smd-edge
>   dt-bindings: remoteproc: qcom,smd-edge: define children

Series applied.

Rob
