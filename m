Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A568C56E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBFSJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjBFSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:09:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683465B85
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1795AB815C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E67C433EF;
        Mon,  6 Feb 2023 18:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675706982;
        bh=U940J3EnfPZHbYF/qOH8zD+T1AjwJgox2zzdFBbhQ1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wDw0DBxTDrW4ogpbsmq4XtxtYT3/FX/D2RNZ2NeHXyhQ2vRdYsnL+0paszlHnryEx
         S2kiixoyhKTxyd1BXkSpVlJdd6CuGc/6kC1e/gqZKsMtwwJqY+MsOi8cqQE2AhbKqC
         ULU4WFDSsaYL3Xi8ngnt3MztWMFC6F4TsW+8d+zw=
Date:   Mon, 6 Feb 2023 19:09:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Visweswara Tanuku <quic_vtanuku@quicinc.com>
Cc:     konrad.dybcio@linaro.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, quic_vnivarth@quicinc.com,
        nicolas.dechesne@linaro.org, srinivas.kandagatla@linaro.org,
        vinod.koul@linaro.org, quic_eberman@quicinc.com,
        quic_satyap@quicinc.com
Subject: Re: [RESEND] soc: qcom-geni-se: Update Tx and Rx fifo depth based on
 QUP HW version
Message-ID: <Y+FCQg4c4XBYk+G6@kroah.com>
References: <20230206122215.22090-1-quic_vtanuku@quicinc.com>
 <Y+D04FIti7yejya+@kroah.com>
 <ca31f247-0297-7582-c16f-a85453872ca4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca31f247-0297-7582-c16f-a85453872ca4@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Feb 06, 2023 at 07:36:49PM +0530, Visweswara Tanuku wrote:
> Added RESEND for resubmission of first version which is not modified in any
> way from the previous submission.

Then why was it resent?  What will cause this to be accepted when the
previous submission was not?

confused,

greg k-h
