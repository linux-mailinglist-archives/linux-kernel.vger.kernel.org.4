Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A017A729027
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbjFIGk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbjFIGkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9991BEB;
        Thu,  8 Jun 2023 23:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B639C60B4B;
        Fri,  9 Jun 2023 06:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14996C433D2;
        Fri,  9 Jun 2023 06:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686292845;
        bh=A1SXMp/jhxOUSEcm9Rmds+1S4ip6As2N3YCZSUy9svI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ynnbn84s6Js2Uw8tC1jAkHDDlSGOQSqgRh53+oj6QjHfj/hJf2kb8QOmZu5xI81hF
         GhrftmGJJRjTZzKo/YoBOwTxaCH0JEgM/gIVXXliwC7QXZFmvYG8Q0LWd6cwpQkMxu
         GgvnP6G2vrD/8kogDB8f/MS10kcfnNZlev6D9iujcioiIReujsqM78PMyVmoHzge9J
         e2ozZ8FFF8y8vPHXxQUyRirSmRkMah3qKGJjSNcUlJ9nJIO+vZG0Nic5I8lpWeRNFx
         ZEWuEBmbvC4hc4dyxJ4zm9nYDQ5W7+C4dfgUj0V4xPuqbFMnRqwiel0+RAK4MJLZGf
         uUuh7c06SLoiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7Vo8-0005PH-14; Fri, 09 Jun 2023 08:41:12 +0200
Date:   Fri, 9 Jun 2023 08:41:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: pm8008: fix module autoloading
Message-ID: <ZILJiFd96TWQAWM8@hovoldconsulting.com>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-2-johan+linaro@kernel.org>
 <20230608154503.GO1930705@google.com>
 <ZILE-Yy8TYaicACV@hovoldconsulting.com>
 <20230609063804.GB3635807@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609063804.GB3635807@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 07:38:04AM +0100, Lee Jones wrote:
> On Fri, 09 Jun 2023, Johan Hovold wrote:

> > Thanks, Lee. Did you forget to push these out? I was gonna see if you
> > merged them for 6.4 or 6.5, but I can't seem to find them in your mfd
> > repo.
> 
> I don't tend to push daily.  I can push them now if you like.
> 
> These were added for v6.5.

Perfect, thanks!

Johan
