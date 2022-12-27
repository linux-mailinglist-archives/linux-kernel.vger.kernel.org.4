Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4687A656D69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiL0R0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0R0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:26:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEA263F;
        Tue, 27 Dec 2022 09:26:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6189461093;
        Tue, 27 Dec 2022 17:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30A8C433EF;
        Tue, 27 Dec 2022 17:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672161962;
        bh=KgtlQqrR+gih/nio1Grf9YcUVnJvl6rD1621rIJqvBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/0L3FE6Rlo32MOKCHIWT5W+7xIwprhZwduvftBP7LoyflmmBP4SF6gkLpwmzE0yM
         /cnLxquKvSxnFEIgJmLu1Uupy0+dcGVCL/0OosP/+Hi8q4Juv1/Ccv6FGahRzZQvI2
         Qa+1RECW3WTbdEU5SR+6+P8WRdQU5WcFM15y+Gkw8en0HVxfVZurlm08KrXSG9/3bj
         kLIJzPzLXOS2QB2in1wzOCmw+V/fT+c88I5fKFDhMwHaF2H+ExIzr5W5Hj7JaWHVus
         WRKHO4yfmxEaOn38w31UJV9AUP2ar10esanEtbsknH+EKcnznkds+SjSP+6zhyjlYZ
         QIHlM44GF9j4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pADiE-0005w1-80; Tue, 27 Dec 2022 18:26:02 +0100
Date:   Tue, 27 Dec 2022 18:26:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: fix resin node duplication
Message-ID: <Y6sqqj7ib2/NYOeY@hovoldconsulting.com>
References: <20221227163810.71121-1-dsankouski@gmail.com>
 <20221227171334.3zfesnmzbjc26sgz@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227171334.3zfesnmzbjc26sgz@SoMainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 06:13:34PM +0100, Marijn Suijten wrote:
> On 2022-12-27 19:38:10, Dzmitry Sankouski wrote:

> > Fixes: f86ae6f23a9e ("arm64: dts: qcom: sagit: add initial device tree for sagit")
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> You forgot to CC me, which would have happened automatically if you
> added:
> 
> Reported-by: Marijn Suijten <marijn.suijten@somainline.org> # https://lore.kernel.org/linux-arm-msm/20221222115922.jlachctn4lxopp7a@SoMainline.org/

You should use a Link tag (not a # comment) for the link to the report.

Johan
