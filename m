Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1437221E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFEJR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjFEJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:17:08 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2578FF;
        Mon,  5 Jun 2023 02:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685956614; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bt92vqC/KJ8J+F82dat/5fo8c0DUqXQNGdiy8U9WuozmZY6gbnMbsKT1qf3R/0ayYb
    Omy9LLVRxunBW0hPH7lkwrqbt/XyhJgRi0TKa5rCMznXC6KTDJOojH1CWRv6JMabYZ2U
    5uOQTxKHOAHFWkwcET0GzSJbD/UsJBCqslcHdS4ieCb7c8SO3NVmOjlXgIO0jWNWzrHx
    uFZhLbIRIe1XfVBwSnC8xh3/JP977sIMP5XZc2zcpWDdgwhqkYaeLS4sIOZmy8NL0SJx
    UCK3mIvowbRzb54CzJCnDdZqPPvsJ2oCuVurea3uLvyTe23IV+42U8FHwbJgTn6Hbmke
    kuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685956614;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y/8gmRS2Mmo/6o0P04FMEj8MQ1YpxHue2slUOt6zG90=;
    b=MKpC4Gi5qkDE2OvdgeyjlsIxJx+1BWfnd7rh1nLQ8f98t5vLs4su+zNisnH1TFWje/
    cTkE37Cvv2YXu16O2b0IgOQ/sxq8nMQ7cCyE/fh7UnAXMqHwbwzm08huM2vtkEZJyTlJ
    mRgSCFpLbiV6Ti+12sIklIfTXBFEZk/Ta+XhXSN35MtxdHlujZr0YjkLJUdc738WHjPh
    48nRTzqDbkOhSTnMw5i1NumiiP6DART3ky02v7OXAMo7x1pShrReZIuMBF7+QzCW41Q2
    FBA+9s5OH5IIl4z+8rqy0Jpxsmmd7lpWIjSslO9hPuPLyA1O5//TPuSvmxvOTbdOvkKV
    g+Tw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685956614;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y/8gmRS2Mmo/6o0P04FMEj8MQ1YpxHue2slUOt6zG90=;
    b=Itoq/TuHW7rWDELrLWD5UtrhzhtaZELO6PVvD9xUQOiIxp+TXgm05pfuDzlilKExrt
    9KimmL6T4Nd8XTHgvtcnEQCnSLsYlMtcD2u74XWGquZEq3+gY+I5PBPaJCMNg6G+O5ZH
    9KIXWSB2WCm9lBb7qry/Ee4VnKz2GujBpS0nady6LJcXG0Myy+QUyGUhaLn4SyO+e3Zu
    JzVi/wKX2NHG+l1QV2dMRZj/37fvH6+eu9wP6ZTCJs3XtU+MlwE2BAL+4vZ7zGJc/9eY
    2V9hdrNVEHNogD/6Ap57f+klag9Jj8ya0GTZbfFP6WL6mC0mjgdDMG0gY7nXEDozeasV
    e4kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685956614;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y/8gmRS2Mmo/6o0P04FMEj8MQ1YpxHue2slUOt6zG90=;
    b=BTto49rNj6EYLv1vLCwvkup6Qqzsd1jb9LzbyIve0AoCkQu8HUMlDvGAdKF5F5/Blo
    7OJELbUcpxQtTImzUQDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z559Gs9Qu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 11:16:54 +0200 (CEST)
Date:   Mon, 5 Jun 2023 11:16:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 05/14] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Message-ID: <ZH2n_tsf2MsIQ6Vf@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
 <168595403632.208907.7805006523202767813.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168595403632.208907.7805006523202767813.robh@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:33:58AM -0600, Rob Herring wrote:
> On Mon, 05 Jun 2023 09:08:21 +0200, Stephan Gerhold wrote:
> > On Qualcomm platforms, most subsystems (e.g. audio/modem DSP) are
> > described as remote processors in the device tree, with a dedicated
> > node where properties and services related to them can be described.
> > 
> > The Resource Power Manager (RPM) is also such a subsystem, with a
> > remote processor that is running a special firmware. Unfortunately,
> > the RPM never got a dedicated node representing it properly in the
> > device tree. Most of the RPM services are described below a top-level
> > /smd or /rpm-glink node.
> > 
> > However, SMD/GLINK is just one of the communication channels to the RPM
> > firmware. For example, the MPM interrupt functionality provided by the
> > RPM does not use SMD/GLINK but writes directly to a special memory
> > region allocated by the RPM firmware in combination with a mailbox.
> > Currently there is no good place in the device tree to describe this
> > functionality. It doesn't belong below SMD/GLINK but it's not an
> > independent top-level device either.
> > 
> > Introduce a new "qcom,rpm-proc" compatible that allows describing the
> > RPM as a remote processor/subsystem like all others. The SMD/GLINK node
> > is moved to a "smd-edge"/"glink-edge" subnode consistent with other
> > existing bindings. Additional subnodes (e.g. interrupt-controller for
> > MPM, rpm-master-stats) can be also added there.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  .../bindings/remoteproc/qcom,rpm-proc.yaml         | 125 +++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/soc/qcom/qcom,rpm-master-stats.yaml
> 

I think we can ignore this error: The qcom,rpm-master-stats.yaml schema
exists only in the qcom for-next branch at the moment, which is what
this series targets. The base-commit in the cover letter also points
there (although I guess it might be tricky to resolve it reliably for
automated testing).

Before sending this series I verified that there are no dt_binding_check
and dtbs_check warnings or errors when applied to the correct branch.

Thanks,
Stephan
