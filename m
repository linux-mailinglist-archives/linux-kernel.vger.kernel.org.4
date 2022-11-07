Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE9861FBD5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKGRs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKGRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:48:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA3B1EC56;
        Mon,  7 Nov 2022 09:48:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49255B81604;
        Mon,  7 Nov 2022 17:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CAFC433D7;
        Mon,  7 Nov 2022 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667843331;
        bh=/1aHkmsDfKUlpT/JNknNQcO+4cTRkiJFJCt5p4N5myY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=benXWyNH6JCJ6jR4eJp9QakuBBSotX8dvtvpHZa0HuIvlM8mEC96Z3hWGhG9W0R/b
         khAbsxVuXi16SuIJdtuso7OsgrQl0Ds5/ZphLNpCxD5HZDm6g57NVsdJssXATnWw9/
         VU3uH0QZxA+pq3V49p3MgT+zqN2xfkcSwaZpIXI0oFLR6BVWmMmv+AgHiB53Um8Civ
         6HndYRXNbtQmAGqI2T912fxDbyQ/YjWRYR8rHhfnAeCpWMgHv7EAvkMXuBsiIR4hjV
         6t7ziU3wZZX8BwML6x+GtDL0qNhe9I5oqM3ePSznKZmAzg+VHjROizB3Oaa05fB3h4
         XYNN7uHJWepGQ==
Date:   Mon, 7 Nov 2022 11:48:48 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to
 rpmpd binding
Message-ID: <20221107174848.lwq4ma62bj5b2fkt@builder.lan>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
 <20221026190549.4005703-3-quic_molvera@quicinc.com>
 <23e8a609-345f-a8ce-b0cb-2926fd86a315@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e8a609-345f-a8ce-b0cb-2926fd86a315@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:25:42AM -0400, Krzysztof Kozlowski wrote:
> On 26/10/2022 15:05, Melody Olvera wrote:
> > Add compatible and constants for the power domains exposed by the RPMH
> > in the Qualcomm QDU1000 and QRU1000 platforms.
> > 
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> 
> Looks good, but you did not Cc maintainers and  they must see this patch.
> 

$ ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/power/qcom,rpmpd.yaml include/dt-bindings/power/qcom-rpmpd.h
Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT,in file)
Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

So you're right; Melody did miss Konrad in the recipients list. But he's
typically doing a very good job of keeping an eye on the list - and both
you and I got the patch.


Why didn't you add your R-b if you think it looks good?

> Who do you think will review and pick up this patch?
> 

Per the maintainers file that would be me, and as you don't seem to
object to the content of the patch I'm queueing this now.

Thanks,
Bjorn
