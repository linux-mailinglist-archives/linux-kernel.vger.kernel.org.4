Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09A1708669
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjERRJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjERRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C544AB;
        Thu, 18 May 2023 10:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F5861889;
        Thu, 18 May 2023 17:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AB5C433EF;
        Thu, 18 May 2023 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684429745;
        bh=Qm04zr0gSo5j8CHzYq69b7TQ96spiaJHuZriamU5aFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D84hh/0XA0ozwmpMMrs4sFMjViu1VoMJRP6GWM9Nzg3Up7bN7caKpV+nTl3MqSE1d
         2NBAnTfzjAD+g8HuVJ7QmIzi1/HxdzPKIK9dphKMBDa5z8cnSyFyt2FSp0sw6gBhxz
         YEFfZijdUynl4EAAUyfNkjp4jfMtyusPQjHEL05u7ss+GrZB3ljzTBw6c8+xFkVA+x
         ZfST8N5IG0x9P2h8dw5bbzeiyz3mHqkXy4l61rZWSMhuHGkLzCJwetSsznX9PZBsNA
         U3kjzI4foq3gcY9jB29N7xoIAW8NYOJF1SdxMDIKfNmnLuaoWMmi0T2OG4lmZJcKHF
         AzVFuF88OdTUw==
Date:   Thu, 18 May 2023 13:09:04 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Svyatoslav Ryhel <clamor95@gmail.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 6.3 01/24] ASoC: jack: allow multiple interrupt
 per gpio
Message-ID: <ZGZbsIMIa6qgU0ht@sashalap>
References: <20230507003022.4070535-1-sashal@kernel.org>
 <ZFg2ZWqEBkPsJk+Y@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZFg2ZWqEBkPsJk+Y@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 08:38:13AM +0900, Mark Brown wrote:
>On Sat, May 06, 2023 at 08:29:57PM -0400, Sasha Levin wrote:
>> From: Svyatoslav Ryhel <clamor95@gmail.com>
>>
>> [ Upstream commit a2d4051b0bd6dffcd736888ae89a550d6f60b060 ]
>>
>> This feature is required for coupled hp-mic quirk used
>> by some Nvidia Tegra 3 based devices work properly.
>
>This is a new feature, why is it being backported to stable?

The quirk aspect of it :)

I can drop it and the other patch you've pointed out.

-- 
Thanks,
Sasha
