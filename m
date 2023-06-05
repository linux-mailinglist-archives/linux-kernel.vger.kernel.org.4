Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2065722E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjFESVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFESVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62AEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 671376292B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B97C433D2;
        Mon,  5 Jun 2023 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685989299;
        bh=XILyVGCrV1RwhErsOtjHXQIissMx6pKKMWDtLGx445Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aDpebFeKwEyDph4I14Q8EevvmAIrdcL5/ji0elqcEhxHJgSCoVdQQO7i9zBDnnE0l
         XbDbF1xj/g0oVEP8Rn3ramrDpCNjOhDSv9xeeAuLKCSd+KgCwR3my81F8+1/svlnXe
         sxWym7wKhmrLdgtgn9ca4LqtTCxBFHyKVFnrWOqtt9kTvwvN1JfqktGjQh967wDpAj
         wZCnGrY29n+B2uF/HRQ/2Qi5ck6C0rGA83nvISrCq/Slmwn7k8npKqw3A7/Qvv7pV6
         yIu0UkHPj+nOcvyTpA5RrhwlWdjsMWeiPai/lUkXuNAMQz928gAaC9R495tdAk6r4P
         FhbOKDx7AlOwA==
Date:   Mon, 5 Jun 2023 11:21:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next] ethtool: ioctl: improve error checking for
 set_wol
Message-ID: <20230605112138.7fb4b963@kernel.org>
In-Reply-To: <1685566429-2869-1-git-send-email-justin.chen@broadcom.com>
References: <1685566429-2869-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 13:53:49 -0700 Justin Chen wrote:
> The netlink version of set_wol checks for not supported wolopts and avoids
> setting wol when the correct wolopt is already set. If we do the same with
> the ioctl version then we can remove these checks from the driver layer.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

If I understand the discussion correctly the patch is ready to be
applied. Could you repost it? It has been marked as "changes requested"
in patchwork, I'm not 100% sure about the reason.
