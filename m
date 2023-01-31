Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E76682C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjAaM2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaM22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:28:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155641B4D;
        Tue, 31 Jan 2023 04:28:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20A8AB81C76;
        Tue, 31 Jan 2023 12:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B510BC433EF;
        Tue, 31 Jan 2023 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675168104;
        bh=6s+C+6fb5oc4CDzOFxiI0nlwhy5299qc5Lrzw/fcOzM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ITUw/wUSQynoWoEBrMVTfcowXP+zNHUsoFT+LjmjoPxJCgzXGsVj0WVCW/5B2swEt
         2uI8cW44A2Hx2kbY5KSonA7fRFbHGRYMtzIGCKAP2Gx2t09pkSBm3yhqam7IA8HPoP
         jzhR1wbLZFUqhxliX6xhTLMyw3j/DDA7BttZnW2q+31Cy4xoxyGRq/3Rp8cyN0gQz2
         Na+rW/DZORyAByZALE5xKWhjujSPXgw+vixYFJDasjnTIGpQsYuqdVRoNZyJIPJQGt
         3hZe1YIOoFrH/SBL4rQ6F/Q/CsIz+EbRXKj0j5ubYzTjtu0SGmYJKCgsRsS+ulbel7
         t7hNoL56FqHaA==
Message-ID: <cd603e63-1599-8225-bfa4-c1c7a3e4cea2@kernel.org>
Date:   Tue, 31 Jan 2023 14:28:20 +0200
MIME-Version: 1.0
Subject: Re: linux-next: Signed-off-by missing for commit in the qcom tree
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
References: <20230131161128.3845f226@canb.auug.org.au>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230131161128.3845f226@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.23 7:11, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    bb8379ce26d0 ("dt-bindings: interconnect: Add QDU1000/QRU1000 devices")
> 
> is missing a Signed-off-by from its committer.
> 

Thanks for the report, Stephen!

Bjorn, feel free to use this branch: icc-qdu1000-immutable

BR,
Georgi
