Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A104872AD87
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjFJQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFJQwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:52:10 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1AA26B0;
        Sat, 10 Jun 2023 09:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686415926; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=S9tuWrHM9P+DwbMzIWWJRvgBYqviXieKUUL9XWt4RigB2zwzvZzUxrM25bXtcXNmwK
    a61HYo2YnnwvVelVR088vIFhnxvyjXYtPzDUl+MkirujDfrP+c+/gI2UAXNXxuLYHVmT
    JF242tHKxpooHcy9uLE0QRU8uSVDRhm9gIE14r4qHhXNj7gAxdbcVPz7p1cFiCynWOyi
    UDDlfgZ8Vo65RPLqfBVM8F52ejJKA4FYzxzIi03e6MMRSI55qrkulhxMwYq0K/u0AYD2
    T6ybeZ0H2plWb7K610RnRDXTwXaJ/RZzIf7CxHr00mRypcnjF6nZSLQIDX9nJwdunFJR
    vPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686415926;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=QWIRPWXgw/uXm0KjKjXznsIUsIykKDfMwhJ/S2bPOrE=;
    b=rmP7bcyR2HDLLSeUXXrqOffceZhKyAtQ796mxNZwt/I5WFVA47bJzWjP6mkob9+DIO
    pkn0euJQcChYe2wyeEYsde+SsUt+QQRa4qebA7wBefpsZJbfuPROziY45KI3gGf1Zh6l
    UmTaOO8opjRbZUczAOlGfyQ1wUv3Ticd73Y7lQZfO/pugycgW0eG8YfphXdSWtHpeLgi
    qe4HGBwovlcnvEdRY+Drei+nRnRUkKH/b6yeoFNZgg0eNu4CORaoka5NpSSzyQqf5VPC
    Eoah4zT5eEqfW7tuOGwssslziKHmv4xYy3ms2vRwbnJw3YcGsVDVrcVSX0uLRK7sxYNf
    Ah2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686415926;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=QWIRPWXgw/uXm0KjKjXznsIUsIykKDfMwhJ/S2bPOrE=;
    b=akLBgHXBJdPQyaTJRYWr6t0syQ93uLKt0Tm23WYuBJEhIYKYuwXdG6QYnSIGf+S8vT
    c1auiMaL2j/YocueXoEuzlnkXZBsmAR0GtgiGB2qv40cG1zMh72kFp2rG1CzPk9w7YQh
    kUql4Hl+f0vhqJTOxw5Asew6CKF6Hr7GHAAM89V/SKkK4DMGumULDH78WePhCHKLsI8/
    tkGjhm1GyOW8mSVCw0jwL6LCDkUcnTiiy++4GCjs8IBzYrCsIR3s2PCFWZixC0oMPR8G
    VARpiBFnKFLQlJUzTd4CrOsjb6rPteW2WEloIUGQcx1R5b6dgfApM3A7uU1PdMn8MS1r
    N+XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686415926;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=QWIRPWXgw/uXm0KjKjXznsIUsIykKDfMwhJ/S2bPOrE=;
    b=zwSi5lfSpJ7AnKLDZ/74+CyGQVo0tfEBcaWhfcmtSIzkqc1NBTkM9M7EK/QKQ0T0Q5
    wGdI+WRSM3T8x+wZFBDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AGq6QY3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 18:52:06 +0200 (CEST)
Date:   Sat, 10 Jun 2023 18:52:04 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 05/12] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Message-ID: <ZISqNPnQgPNEsmxa@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
 <20230531-rpm-rproc-v2-5-56a4a00c8260@gerhold.net>
 <9cdf22cc-6509-b87e-e631-4e3633d1f542@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdf22cc-6509-b87e-e631-4e3633d1f542@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 06:43:17PM +0200, Krzysztof Kozlowski wrote:
> On 08/06/2023 09:10, Stephan Gerhold wrote:
> > On Qualcomm platforms, most subsystems (e.g. audio/modem DSP) are
> > described as remote processors in the device tree, with a dedicated
> > node where properties and services related to them can be described.
> > +
> > +  smd-edge:
> > +    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
> > +    description:
> > +      Qualcomm Shared Memory subnode which represents communication edge,
> > +      channels and devices related to the RPM subsystem.
> > +
> > +  glink-rpm:
> 
> This should be "glink-edge", to be a bit more generic and match existing
> smd-edge.
> 

I fully agree and I actually made that change at some point before
sending v1. Unfortunately, it doesn't work: The node name "glink-edge"
is already reserved by qcom,glink-edge.yaml. While it's very similar it
has some subtle differences to glink-rpm-edge.yaml. For example, there
is no qcom,remote-pid in the RPM variant which is required by the normal
glink-edge.

Would "glink-rpm-edge" sound better?

Thanks,
Stephan

