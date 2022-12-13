Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40AC64B8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiLMPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiLMPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:42:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B62229A;
        Tue, 13 Dec 2022 07:42:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25224B8123F;
        Tue, 13 Dec 2022 15:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B326DC43392;
        Tue, 13 Dec 2022 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670946149;
        bh=w15z9/GwHbssv+3zLnYaCJobp9cRRcve+pRpo3G+gnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD5RlaeB8k6h1qkjWkmsjCkOxP5LFQzezUHxCSi2FkfJ/gHqr7iFqLHze7TDlHM9r
         Jd6lUIU7r9DAOK6gqyd4JLEUiFlm4Wx9oKaEOPzDfEhje21oZcyIyEvEv+Y0xdbFGo
         omKlHylmiTzyPf1Y1P3dNjhmC9/GhQmBR3d867hxbQZ3i3xmoYnh1XbRnHSJIIGlY0
         k2MZBgRN3AKBCepYanuOjLA3QxRC7WjjqiYdGxH3jgWGh2th1dUFJau4RZrI/dMDH+
         oU3Tw0Q6cjJn5eoTDEfZFpLDhcfbmdky3YACZ6gKe9DFoE0LIZDhEev1EpcF7pirE1
         aYRvsJdsk7OvQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p57Ql-0005NX-LS; Tue, 13 Dec 2022 16:42:55 +0100
Date:   Tue, 13 Dec 2022 16:42:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5idf5dP2ttBSOUa@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iWeTk2zOp9rInx@x1>
 <Y5iaDP+nV9B59U2b@hovoldconsulting.com>
 <03252ccd-e200-a112-b4dd-ba9fbf25c480@quicinc.com>
 <Y5icyo7I5ZGAL02q@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5icyo7I5ZGAL02q@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:39:54PM +0100, Johan Hovold wrote:
> On Tue, Dec 13, 2022 at 09:04:39PM +0530, Shazad Hussain wrote:
> > On 12/13/2022 8:58 PM, Johan Hovold wrote:

> > >> So qup2_i2c18 becomes qup2_i2c2. Would I use the flat naming scheme for
> > >> the alias like so?
> > >>
> > >>      aliases {
> > >>          i2c18 = &qup2_i2c2;
> > >>      }
> > > 
> > > Or perhaps the i2c controllers should use a zero-based index instead of
> > > being named after the serial engines (e.g. as we do for the console
> > > uart).
> > > 
> > > How are they named in the schematics?
> > 
> > We should use from 0 to N.
> 
> With N being 23 after the number of serial engines, or the number of
> available i2c buses on a particular board minus one?

Looks like the more recent Qualcomm platforms use aliases that reflect
the engine number (i.e. 0 to 23) for i2c and spi.

Johan
