Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F86522B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiLTOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiLTOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:34:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A55186F2;
        Tue, 20 Dec 2022 06:34:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56DD0B815CF;
        Tue, 20 Dec 2022 14:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA683C433EF;
        Tue, 20 Dec 2022 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671546869;
        bh=W9dcRGm4djkjFr6HhOGNrpLLjHWEwTIfrkR7EUSe5cI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=c88Nea8pFzC298P6dPW87GNrnKEUbp//MmMQQqq7EahTjZUcCYJ8kjcxqRXq5G1Aa
         38dp5wjmR0fZXovck7CkQ0TNzPu9Yq/L5LT92dJspRi7OmuSS/Fv8kzZ8ZTLw4r3g8
         SIGNyjHLmf9oh3I7n/W4u56MON0a7soxiNBbZkdSv8Pha71X7rXxrg8H9ozam2Pwtd
         LZ3zP6T/V9mE6sOZpz+HdkEQRqgOTDtQbhHBfGmpXG2JnYC9yF+81LpytHdcbhHSHb
         g+uHjORMA+hyQl0iVUqMn3VMoYz30bk16tIGwCOJR5LwGa8GgTXsWvcsJobat7oVlo
         hXUMSuraadYkw==
Date:   Tue, 20 Dec 2022 15:34:29 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akito <the@akito.ooo>
Subject: Re: [PATCH] HID: multitouch: fix Asus ExpertBook P2 P2451FA
 trackpoint
In-Reply-To: <20221128165705.7008-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2212201534210.9000@cbobk.fhfr.pm>
References: <20221128165705.7008-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022, José Expósito wrote:

> The HID descriptor of this device contains two mouse collections, one
> for mouse emulation and the other for the trackpoint.
> 
> Both collections get merged and, because the first one defines X and Y,
> the movemenent events reported by the trackpoint collection are
> ignored.
> 
> Set the MT_CLS_WIN_8_FORCE_MULTI_INPUT class for this device to be able
> to receive its reports.
> 
> This fix is similar to/based on commit 40d5bb87377a ("HID: multitouch:
> enable multi-input as a quirk for some devices").
> 
> Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/825
> Reported-by: Akito <the@akito.ooo>
> Tested-by: Akito <the@akito.ooo>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied, thank you!

-- 
Jiri Kosina
SUSE Labs

