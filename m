Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A008D70DD40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjEWNM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbjEWNMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFCA109;
        Tue, 23 May 2023 06:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECC2760B2C;
        Tue, 23 May 2023 13:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E37BC433EF;
        Tue, 23 May 2023 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684847530;
        bh=nVNVKCroG2DRvFC/0imQI8MOw3h1mDhbsG3ornLiA1k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GDQ+ipEmwgAM4KkwIlbeNpcF11aXBoZgQo5Utfi0u4R24Ktdk9PI/2nImGwpKMJgy
         TY2Kq121LeNckPgZI3+jbXp/hFaqN6AuNnsW/NAl4TB0SkIgCGkFKpbsDOLjloo8yC
         0wqQtjGGuH48mrKOuIxWHPK5z/z3JZTjrLN/vP1v+b8vBc2EYyMz14MHooItn26O8w
         J6KnepEi7B0V8qO2MFl+4gSoluxgckryEyj8g52nDWGC25vLy5O+u9VN+Ssf+h3sRz
         oEBs6GGZvNEJeSaya5NjS1EWJbN4CQ48t5Z5c3N0P0p4WjS+6V+dZTGosGvFe7QVam
         DdaBNVOtxuOqw==
Date:   Tue, 23 May 2023 15:12:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Arefev <arefev@swemel.ru>
cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] HID: wacom: Added error check
In-Reply-To: <20230427114745.53136-1-arefev@swemel.ru>
Message-ID: <nycvar.YFH.7.76.2305231511590.29760@cbobk.fhfr.pm>
References: <20230427114745.53136-1-arefev@swemel.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023, Denis Arefev wrote:

>    Added a variable check and
>    transition in case of an error
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

