Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BFE61634A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKBNDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBNDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:03:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47ABCAE;
        Wed,  2 Nov 2022 06:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5563AB82213;
        Wed,  2 Nov 2022 13:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F189DC433C1;
        Wed,  2 Nov 2022 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667394217;
        bh=QobtvX60ddRtfbopQpHBxhaxwuftQtyQo7jI5rT+2gA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=soeCkfd25ehokqnkxC6gZLcMNPhcvsGg/xnQ7jlQne6I+N8tHXLGztEA7ROTb3CqA
         A5TzgEMmOlp6WNCDECBb/aldI3nur0dxMH6Q6z8o+1uR3NrMp+DL1XZaG1sKwe0/lL
         goI2It6mTXOcIaJR/W4HPfP0RnqstHmZUuS8Xba0rfKzVrD54IXjVbbkJG7FGgNlBf
         0H3y53+Dnany7rcxToE/eO0oQpgjxO9Rcpl5BiNj1rwJBlSbK7flO+e95FExeYeh49
         H7NnvmeFYE5PbkO+v7kBdiBai9oGSfHSBaF4SrGewCTTxs6Rc7EjRkxr51Qrmnh8md
         G0JyhnmA4KESg==
Date:   Wed, 2 Nov 2022 14:03:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kerem Karabay <kekrby@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Version 2 of hid-apple fixes
In-Reply-To: <20220924095306.8852-1-kekrby@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211021402500.29912@cbobk.fhfr.pm>
References: <20220924095306.8852-1-kekrby@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022, Kerem Karabay wrote:

> From: kekrby <kekrby@gmail.com>
> 
> Hi all,
> 
> This patch series is an updated version of this one:
> https://lore.kernel.org/all/20220910094354.12359-2-kekrby@gmail.com/.
> 
> # Changes since v1:
> 
> - Fixed loading the module with the `swap_fn_leftctrl` option set to 1,
>   which would make the Fn key cease to function. (Setting the option
>   after loading the module still worked, which is why the bug was not
>   caught while testing.)
> 
> Kerem Karabay (2):
>   HID: apple: fix key translations where multiple quirks attempt to
>     translate the same key and the ones that depend on other
>     translations
>   HID: apple: enable APPLE_ISO_TILDE_QUIRK for the keyboards of Macs
>     with the T2 chip

I have shortened the shortlog of the first patch a little bit :) and 
applied, thanks.

-- 
Jiri Kosina
SUSE Labs

