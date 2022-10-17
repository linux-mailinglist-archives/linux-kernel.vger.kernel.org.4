Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F86016AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiJQSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiJQSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:53:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E82072ED4;
        Mon, 17 Oct 2022 11:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0D64B81A07;
        Mon, 17 Oct 2022 18:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DF8C433D6;
        Mon, 17 Oct 2022 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666032781;
        bh=C66mwBKGI4sGhp3xFNXJubKomDIABpOsyvvNJJF92x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evIWIL0auAwcHXkS+bVJx6jaTghK7FOVP/6LY2hkm1YDab8zrZO6GwuxVu3amLD2g
         Iae6gB99vdFN1BuCMHhqe1vrkH+4YGeMHUlAfqoLeXuNv+N2GlW9JMfD/fC+dGE/c8
         XrXZ5nzc/hfxajrAffaZBjVX4jI1N8zK3Fg0xLM8Zkrk4eC6TbvpDGY4FT1ZZ1+Zvp
         ed4AZEZHSOK08YMpG2JanLAvfd3fSoInHVJX1zm7GRoHj5DevdAiqS6LMc9zJDzxCT
         fd92an8lVjiP2V+XUCogVIC6+k19nA4xjDIo9IX285GE+NRTejDvkEkWfQ78g6bPUB
         aHRzfiMbo3VeA==
Date:   Mon, 17 Oct 2022 13:52:58 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Message-ID: <20221017185258.l3bvm2cmfr5q36xy@builder.lan>
References: <20221003125444.12975-1-quic_ppareek@quicinc.com>
 <20221003125444.12975-4-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003125444.12975-4-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 06:24:43PM +0530, Parikshit Pareek wrote:
> There are many ADP boards with lot of common features. Move common
> nodes, like remoteproc, regulators etc. to sa8540p-adp.dtsi file.
> This will be base for many ADP boards to be introduced in near future.
> Common nodes are like clocks, remoteproc, regulators etc.
> 
> The differences between the sa8295 ADP board, and sa8540p ADP board
> (Qdrive-3), with respect to device/connector-interface, are as following:
> 

After reviewing the qdrive3 schematics I do think that describing the
two ADP boards as a delta between them is not going to serve us well in
the long run - they are quite different.

So let's just create a new dts for the qdrive3, and if there are
additional boards they will either again be sufficiently different or we
could turn these into dtsi files and inherit from there.

Regards,
Bjorn
