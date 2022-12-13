Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA964B818
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiLMPKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiLMPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:09:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097BF64F3;
        Tue, 13 Dec 2022 07:09:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A82C6B811D8;
        Tue, 13 Dec 2022 15:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05C3C433D2;
        Tue, 13 Dec 2022 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670944173;
        bh=xGXEA82kBEqZbxT9/Nu5SNY3CO1PQV2Lv3Lly8E2Uis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8cgiEPX7bGmlk76rw87PnZWQAcfjNbSml4bFgUaqCk0iV8f93zau89zqTwRWdU4N
         xBnwg8FUJpY9+8eskrPlaSRF1lplo+z+DuH/QmwrJR2c33ILzuKvy7J9xfuoFFecKC
         SqdG6I4ixQ8OiPerRf1puQfzXA4mZcR1dopf03HI=
Date:   Tue, 13 Dec 2022 16:09:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, quic_kamalw@quicinc.com,
        quic_jestar@quicinc.com, sboyd@kernel.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] spmi: Add check for remove callback in spmi_drv_remove
 API
Message-ID: <Y5iVqrnlX8NoiOkl@kroah.com>
References: <1670145780-13111-1-git-send-email-quic_jprakash@quicinc.com>
 <1670145780-13111-2-git-send-email-quic_jprakash@quicinc.com>
 <Y5hqMFw0xl6lmJYL@kroah.com>
 <367fdcef-7360-055a-897b-71a66063b4ba@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367fdcef-7360-055a-897b-71a66063b4ba@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 07:12:10PM +0530, Jishnu Prakash wrote:
> Hi Greg

Hi, please do not top-post :(

> These are two SPMI drivers without remove callbacks defined:
> 
> drivers/mfd/qcom-spmi-pmic.c
> drivers/mfd/hi6421-spmi-pmic.c

Great, they should be fixed up now, right?

> We made this change after noticing an issue internally with the first one
> above, there was a crash when trying to remove it with rmmod, which is fixed
> by this change.

Then please say that in the changelog text, otherwise we have no idea
_why_ this is needed.  All you said was "add this new check _IF_" and we
have no idea what the answer to "if" is :(

thanks,

greg k-h
