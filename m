Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797D56C5EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCWFcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCWFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE5D2E0E3;
        Wed, 22 Mar 2023 22:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99852623EC;
        Thu, 23 Mar 2023 05:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEE8C4339E;
        Thu, 23 Mar 2023 05:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679549464;
        bh=5tQnInfyM1glGvlLMveAFr71G5YuWbPE3nEwMpsAtHw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qOuovdeYyJLcMiGvwfiZJlmFRbklfKBM4aXWcVQAtprFuBp72TFESKWa3Fh8srQk5
         cCRs59bPpekQXpEHThx3DPuRy1LEDztJ11Zs4x1l90UBhY+3mraJjHX+/btIoXH4fR
         fmrBQkr3d+OlF3nuLADUlnA2fUYG+oMxSEUuH2V/qeeuiqw5SH8N+u43d5R4wO9UUN
         4G+vh7xG9lpF6Fv5tkammvO4y0PQS+WoWJcMFGwMkSAPJzTiYnLMVy/pn99faNpxDi
         HRGnb4Oc/amd8uZAmj9Fx2L836sPGuy/6Xjd69JPL43mBH+kbQNIGcEu6h2K7Kun4i
         Ed7z45xIieF+A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Federico Pietro Briata <federico@briata.org>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: help with Qualcomm QCA6696
References: <20230123090555.21415-1-git@qrsnap.io>
        <167950811348.23855.15517111358348733076.kvalo@kernel.org>
        <CA+KKcbm9qy2yAjVZptTEQa7Z3UALcVbD2GbeHNrYufM6cfvZuw@mail.gmail.com>
Date:   Thu, 23 Mar 2023 07:31:00 +0200
In-Reply-To: <CA+KKcbm9qy2yAjVZptTEQa7Z3UALcVbD2GbeHNrYufM6cfvZuw@mail.gmail.com>
        (Federico Pietro Briata's message of "Thu, 23 Mar 2023 01:39:43
        +0100")
Message-ID: <87h6ucdoff.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath11k list

Federico Pietro Briata <federico@briata.org> writes:

> I would like to use the wifi chipset QCA6696 to create a mesh network,
> best in ibss or 802.11s mode. I got from quectel a wifi driver but it
> seems to support just AP and STA, but from my understanding I shall be
> able to test at least WiFi SON or EasyMesh. Do you know if the support
> for this chip it's avaiable with the community driver?

I don't know what hardware ids QCA6696 has but in theory ath11k supports
that family (QCA6390) of devices, though some changes might be needed.
But ath11k won't help you as it only support station and AP interface
modes with QCA6390 family.

BTW please don't send HTML emails, our lists drop those.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
