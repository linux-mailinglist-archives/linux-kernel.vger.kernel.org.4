Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530A5677A88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjAWMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:06:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC319008;
        Mon, 23 Jan 2023 04:06:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BEF0CE11AB;
        Mon, 23 Jan 2023 12:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8900BC433D2;
        Mon, 23 Jan 2023 12:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674475557;
        bh=xomCv4fVScuMgRQPunTMEDlZt86y3oPZFGZ9j/BTOXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USEasJXMz7HT7THL5/juE79zj86m04PeEMqm6Cf5U3n47ahStCAEKgrrzGxptY/gK
         VPqDP+QaoSIt8m9HlZaiqvdjh73XDYAK2w0Oc5vE86Y8VYf0c4cTggAEsv4OrBq3hG
         boCmwC3mBd7bdpOH+KBUsOCvuDKTW1m9q41N3PvEWnVKsr+n2sKqO0E5bGUBEGHIbQ
         vBC+W1wHK98FZMZM+0bXxTC+WzrWlx9Mrk0EbUQEaAz8Azi/ELsN1w8gRgv4iXINA8
         ZCqUzpStGzI7EIFPLtvQSLVk71io/fHAFoRx3O7WOKkWyPwt4tGSIBU8kqPB3ritj1
         Pt7gKgm9eeWDw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJvaF-000225-2P; Mon, 23 Jan 2023 13:05:55 +0100
Date:   Mon, 23 Jan 2023 13:05:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] phy: qcom-qmp-combo: Add config for SM6350
Message-ID: <Y854Iz7gG6/APILo@hovoldconsulting.com>
References: <20221130081430.67831-1-luca.weiss@fairphone.com>
 <20221130081430.67831-2-luca.weiss@fairphone.com>
 <Y6xP4YRAp68TfxFi@hovoldconsulting.com>
 <Y8BIX+js1ircJyb9@matsya>
 <cf968a25-02f7-d402-530b-eb379b707e54@linaro.org>
 <CPR2LS3SJQ3I.Z7UY505COG3@otso>
 <CAA8EJpoOMMALHz7ysft6KvQaYhGWPD+xZiUjOTrC8CA_y81n-w@mail.gmail.com>
 <CPX2VVT5EUDV.2LH6VI2586F02@otso>
 <Y85WqDrGXAXp7gS/@hovoldconsulting.com>
 <a18359f8-6495-dbea-2323-8ab73bbfc472@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18359f8-6495-dbea-2323-8ab73bbfc472@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:15:52PM +0200, Dmitry Baryshkov wrote:
> On 23/01/2023 11:43, Johan Hovold wrote:

> > We'll convert the older platforms over to use the new binding scheme
> > soon and then we'd need this anyway. And if it turns out later that this
> > was all bogus, at least we only need to fix the driver (and not worry
> > about dts backward compatibility as we had to with the old style
> > bindings).
> 
> As you mentioned this. Do you have plans to work on this conversion? If 
> not, I'll probably take a look during next development window.

Yes, I was planning on looking at this after Luca's series is merged. I
have some higher prio stuff to get out the door these next couple of
weeks first, though.

Johan
