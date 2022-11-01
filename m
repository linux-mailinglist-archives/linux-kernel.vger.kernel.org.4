Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA13614F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKAQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:23:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6A91A213;
        Tue,  1 Nov 2022 09:23:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n12so38231554eja.11;
        Tue, 01 Nov 2022 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QjE9lTE++fclwFa7yMAIrErfvE6I/XCjhnbSuMJSadI=;
        b=HuednwKGDdGrvaUJCdekwxP+OyuF405/uycgqP4ZZkDWTkegfIrL6QXKivPLKzxEVy
         ytOGI0Id3iUMsMWl/bkBr5NDfTZPbO2QNldy621TP7TABjsoofQX0EG58gr2heBwejNO
         624qNm4sfn17mtTtVVml/7uON5U97fFeCmQ5gbPyG1Kd9Qv1oV3rt5Aw4cudGr6DDIj+
         lLKKcSztI0bOhFnZbkJrm1iiUQePy0hU6QRdNco59DVmD/GycjvQZc2FM5FA2eBNSfn6
         mHg9+fF09heSEwonV9UmXI5v7P6t7nNq9mIvhbAQpAOJkFOr2unyC15xgCIiaKDoXBWP
         V5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjE9lTE++fclwFa7yMAIrErfvE6I/XCjhnbSuMJSadI=;
        b=V+eYBzCFSgFJ96Wi+O+iNOBpvHjgoeVLsY0Jxe9ndp0F20tISRYd8SkVvDmcE8fjTx
         wi2NT6lpZApMGpbQXPj6M5B5MnGDs7/UsPXN25PHm4kLMXG2CIi0e+99EiqFX/KRMb6K
         wQs0hZBmt8g+I2v+L6ZSfXApfrngRT2bJ80xKQ92tk3DXrDh7qLAg5JD2aItFUWtKwOA
         cfHkdcnBy5ujhj8y2/odrvsbjRGynhsy4EfycTmCDeiRwvUSPIJW5xSw0CBqIrGhVxAc
         hQsTdtjOVsIgYapC2bslY5ASpKf0ibB3mRe18UeXNG74TqCWlqzfpT63nry6oI9cS6hG
         9eLw==
X-Gm-Message-State: ACrzQf1XSHYl/jWWastj31elQSOnQWJ2n1qjJ1M1pq8lGO+1LAOofxDT
        3l+toPgC7XeMofCvN1p+Bjy+BOQZRWCpx9PJxGI=
X-Google-Smtp-Source: AMsMyM6yCCYE1jRfdc2k7pNZy6hR1Yn704uJKgDoSiQVMAtUpptyljIOsw2MSx8YH4+AHoDsO+yCTAU/SxHwxZmdR2w=
X-Received: by 2002:a17:906:2ad3:b0:78d:b88c:5e35 with SMTP id
 m19-20020a1709062ad300b0078db88c5e35mr149386eje.157.1667319826948; Tue, 01
 Nov 2022 09:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-3-quic_eberman@quicinc.com> <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
 <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com>
In-Reply-To: <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 1 Nov 2022 11:23:35 -0500
Message-ID: <CABb+yY08jP+Q5xvzLf=7F1tULP6-eZz5EDiK9mBj2fAv=iZa_A@mail.gmail.com>
Subject: Re: [PATCH v6 02/21] dt-bindings: Add binding for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:20 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Hi Jassi,
>
> On 10/27/2022 7:33 PM, Jassi Brar wrote:
>  > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman
> <quic_eberman@quicinc.com> wrote:
>  > .....
>  >> +
>  >> +        gunyah-resource-mgr@0 {
>  >> +            compatible = "gunyah-resource-manager-1-0",
> "gunyah-resource-manager";
>  >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX
> full IRQ */
>  >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX
> empty IRQ */
>  >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
>  >> +                  /* TX, RX cap ids */
>  >> +        };
>  >>
>  > All these resources are used only by the mailbox controller driver.
>  > So, this should be the mailbox controller node, rather than the
>  > mailbox user.> One option is to load gunyah-resource-manager as a
> module that relies
>  > on the gunyah-mailbox provider. That would also avoid the "Allow
>  > direct registration to a channel" hack patch.
>
> A message queue to another guest VM wouldn't be known at boot time and
> thus couldn't be described on the devicetree.
>
I think you need to implement of_xlate() ... or please tell me what
exactly you need to specify in the dt.

thnx.
