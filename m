Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4C7735AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjFSPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFSPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834110DE;
        Mon, 19 Jun 2023 08:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FDD060CEC;
        Mon, 19 Jun 2023 15:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA41C433C0;
        Mon, 19 Jun 2023 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687187501;
        bh=FqqTarVZo1tY/NhHJGp28zWP61prGWcbecyJHjKw0aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duy0T79iU15e5g9l9BqbW4jm6METbNVoc66QYsvsbEAQ4lnWopJNCQ0FrOj7QgBed
         EcrHQbh3GdcHVuuk1IItjf8GggkujhMz1r9nKjtwNucTmGVkaOixGoupMdkGIq7BhB
         dzkj5DuDtrNRPIhGNmqGCnkhRE00xvyq3bOx5J//zfRlwFPgVzp3K1xjpl4o4aDUWH
         R7xUBUBVNDMaOQg1vYd6f5lMMtjE1g/tHgiK6Nba3UUfkROSBW6pjL/ARi86QUAv42
         TPWjLx39JTitKYX41LXDFoZ6ijJZcWu5N+4ZQ8zy+RRLdss/q5sKXPEG76MqLiXwgW
         yQhNfmDmTdZEg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBGXb-0003bU-Bg; Mon, 19 Jun 2023 17:11:39 +0200
Date:   Mon, 19 Jun 2023 17:11:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_ugoswami@quicinc.com
Subject: Re: [PATCH v3] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Message-ID: <ZJBwK3j0aHFF7J4U@hovoldconsulting.com>
References: <20230618120949.14868-1-quic_kriskura@quicinc.com>
 <ZI_-c5g20DSJOSu2@hovoldconsulting.com>
 <fca531e0-88ec-ba19-2c11-e8965ac653b2@quicinc.com>
 <ZJBvBE-xy2X_wWO0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJBvBE-xy2X_wWO0@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:06:45PM +0200, Johan Hovold wrote:

> and it also looks like we'd end up with an active-child counter
> imbalance if anyone actually tries to do so.

Scratch this bit, I misread the code.

Johan
