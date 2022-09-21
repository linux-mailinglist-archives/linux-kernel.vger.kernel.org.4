Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4A5BF6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIUHGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3552F491E3;
        Wed, 21 Sep 2022 00:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C43C062F76;
        Wed, 21 Sep 2022 07:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FCBC433C1;
        Wed, 21 Sep 2022 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663744000;
        bh=Ao2IgbeJQHW+cfXH8akjw/H7pJL26xNuSr60HBNqO8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fppbgRKzPp2ynnZBDf+LdLBFj+ss9Qmtf+rxjJta9qvPpS0SNaviDkNxnRlYwqWGj
         6cgSIi8RcM8c1jtuaezPirKl05URpL7k1kWe27M0WZArS3OIOt7tyyUOANTHmbuDQc
         MIF/GZ9GBmAHlUFsE3ZTnEhIC18812v9CkBnshmzgdpOD62uovbQfZ5WXoWEgz3nSR
         MI7KUtLphqUizMAlBa9boFDX+9UwdR7PRisHhko8PuLtBaOgpy3wRTxZEEH/jzngJO
         qYl2/1Meq0Hp7LAd40BkDrZmRqjoXIElIJWxc0Ko6uqpf2C2bW8Cb1B2vv79oc3L0B
         +MUs1Mw7u1yxg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oatoh-0003iP-Ia; Wed, 21 Sep 2022 09:06:44 +0200
Date:   Wed, 21 Sep 2022 09:06:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Message-ID: <Yyq4AwAbk3nxNUAl@hovoldconsulting.com>
References: <20220920120802.14321-1-quic_ppareek@quicinc.com>
 <20220920120802.14321-3-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920120802.14321-3-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending with Bjorn's address updated. ]

On Tue, Sep 20, 2022 at 05:38:01PM +0530, Parikshit Pareek wrote:
> There are many ADP boards with lot of common features. Move common
> nodes to sa8540p-adp.dtsi file. This will be base for many ADP boards
> to be introduced in near future.

I already asked you to include a description of those differences here
in the commit message so that we can make a decision on whether this
change makes sense or not.

This also needs to be documented for future changes. For example, when
I'll be adding PCIe support to sa8295p-adp I'd need to know whether this
should go in a shared dtsi or in the board file.

For reasons like this, I'm still not convinced that this is a good idea.

> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 392 +-----------------
>  .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     |   0
>  2 files changed, 14 insertions(+), 378 deletions(-)
>  rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (96%)
>  copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (100%)

Johan
