Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9A6EF1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbjDZKVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbjDZKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:21:43 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A1135B1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:21:41 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4408b81ed86so2502555e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1682504501; x=1685096501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5ddJJouQF0VMg4gLphGJLFIlcb6TbSvOUl9yWeTAB0=;
        b=zsa8P4i496EbZ9/9LRHfm1Evv1CuEbHUX3snQ7nJzrrN0Bpetkz5flyHJBq7GP6ZY+
         ZDN6lYgi03rJQ39TC1ONkGoUcnlTYaO0wTAknsa6BEO/eZptGfP1/Wk2rmxhy/cDFN1u
         fg3uQNBGXXdLlL6QwJiPFNXIFOy0hEHCB3i8MvIUiBou7zklIKfvkGQfz43o8VohfGVc
         OJ73U3gxiNbCx7ZScD0ypfbdJe9zxRLZyfk7N+HBB2GvK2XIuQULBsMPhSVdFNuvjmfy
         syVmhZd7P4Z8sWbz7DAh7rUGfzOu/vgvoLnTXgTRg9jgTLEXnfmupwmlsNLk2kOB/PVJ
         5Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682504501; x=1685096501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5ddJJouQF0VMg4gLphGJLFIlcb6TbSvOUl9yWeTAB0=;
        b=WC4hDSw0sC9Au1Gjq1thn5YcKWmohSeAhujPRTLwSvqFKQAkdxJq8rSwDj6fhdFlE/
         oFwn3TVI0vvCXnJIzkByYYDB2Wrw05N5as7k7rfm6SgT4qRpX4D8RrMqsm2uNhPS8CEx
         ToXMiCujqnithRzhF8vXp7vBeV5HIGyN5u0GAWgRlglBZuDfLnX2YBzqjsJtaYkq8R+V
         6v4evq27jv4rIAP+AXlW6iHo+Du9W5THifX5PIYsP5JD1u88y+mu9tppFeWlysYMXtHh
         JYNEK/sqe8cihgulHnJkYON3MKYgW12ns2VTuMUHqkrSu4sGcIIHXo26PaxyCCe/cPGo
         vlBg==
X-Gm-Message-State: AAQBX9cvoWze4MEjbiWXbMt8gsBG2wJoIt+ORbsJp3A7Jr2cfcn7oTI1
        JUZ29Qpui8+tQoBehmkpMLvfQm4eZh72L3A/rGvbhU7Dkaw4N1R8
X-Google-Smtp-Source: AKy350Zi9Q1Lktqu4EEULyrk/A02CU31Usyj5JoncFgGwtXrBx71o/Oi0fhGYphHH3NKVhpiK4Dqe5GdaCdrPCC9fZc=
X-Received: by 2002:a1f:4f83:0:b0:43f:bcdf:b60e with SMTP id
 d125-20020a1f4f83000000b0043fbcdfb60emr4937454vkb.0.1682504501111; Wed, 26
 Apr 2023 03:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com> <20230425034010.3789376-2-quic_bjorande@quicinc.com>
In-Reply-To: <20230425034010.3789376-2-quic_bjorande@quicinc.com>
From:   "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Date:   Wed, 26 Apr 2023 11:21:29 +0100
Message-ID: <CAJB8c06H+3pxoUGXWOXyCgtbOj6y0OhSxb9dvoTo1b6iChy7ng@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add
 ports and orientation-switch
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 4:40=E2=80=AFAM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> The QMP combo phy can be connected to a TCPM, a USB controller and a
> DisplayPort controller for handling USB Type-C orientation switching
> and propagating HPD signals.
>
> Extend the binding to allow these connections to be described.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb4=
3dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb4=
3dp-phy.yaml
> index 3cd5fc3e8fab..c037ac90ce7f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy=
.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy=
.yaml
> @@ -60,6 +60,26 @@ properties:
>      description:
>        See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
>
> +  orientation-switch:
> +    description:
> +      Flag the PHY as possible handler of USB Type-C orientation switchi=
ng
> +    type: boolean
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output endpoint of the PHY
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Incoming endpoint from the USB controller

Do you really need this one ?

The controller doesn't process orientation switching.

---
bod
