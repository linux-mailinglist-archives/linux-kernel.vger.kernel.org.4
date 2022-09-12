Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100415B5BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiILOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiILOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF6320BE4;
        Mon, 12 Sep 2022 07:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71E6DB80D7C;
        Mon, 12 Sep 2022 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D14EC433C1;
        Mon, 12 Sep 2022 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662991676;
        bh=DNFh/8fnywH/RCXf1m7yXCkKfQNpT2EqKS2/KC5HhVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6AZxVoxkg2CNkmUk2oL5OT7fxwNc8Ze9D2/gt1h+c8G399Eq1v3Mn5LwcBquDXoI
         U1L5X9mjrH9k2nnM0574a+pbvBe1s5yj/NDkpdvbyJi6lKNZnhhJ2cEHfhudHNSGxf
         xWE3EwXiqVFkJl148Ovmf75Yauj+ovUrPxLhd3wI=
Date:   Mon, 12 Sep 2022 16:08:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] usb: dwc3: gadget: remove the unneeded result
 variable
Message-ID: <Yx89U/7JCfblSdHS@kroah.com>
References: <20220912102854.18277-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912102854.18277-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:28:55AM +0000, cgel.zte@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> Return the value power_supply_set_property() directly instead of storing
> it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  drivers/usb/dwc3/gadget.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Sorry, I can not take this as you are not following the researcher
rules.

Also how do I know that this gmail account is really from ZTE?  Please
work with your company to fix this.

thanks,

greg k-h
