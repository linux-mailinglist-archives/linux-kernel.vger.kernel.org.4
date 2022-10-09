Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897815F89D3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJIGvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJIGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782EB2A43B;
        Sat,  8 Oct 2022 23:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1553F60B86;
        Sun,  9 Oct 2022 06:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F278C433C1;
        Sun,  9 Oct 2022 06:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665298274;
        bh=cBUWUX/wKjFbBTSR4Zh5FNhzEenYZ+ABG2uNJqaEQsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frDCiFn3Jr7P510TeiwpjOyrNMYrkiSGac06hyTwM+eGqjB2U2ZU/Gsxn4mMmhLPI
         5Tc/Fzr3dEC/ePBprRXHbkDyBP1BAP2lnr7vZIkJU683aDhx3YKwYkKYpNoBBTY/SG
         ZjfTUs42t0SfoomAz8pZIVERgvbyI4HNthe+mm0Y=
Date:   Sun, 9 Oct 2022 08:51:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dlm: Replace one-element array with flexible-array
 member
Message-ID: <Y0JvjAfnOB13y2wL@kroah.com>
References: <Y0ICbf8tCtXMn+W0@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ICbf8tCtXMn+W0@mail.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 12:06:21PM +1300, Paulo Miguel Almeida wrote:
> paulo.miguel.almeida.rodenas@gmail.com
> Bcc: 
> Subject: [PATCH][next] dlm: Replace one-element array with flexible-array
>  member
> Reply-To: 

Something went wrong here :(

