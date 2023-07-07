Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762E274AEED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGGKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjGGKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58832172B;
        Fri,  7 Jul 2023 03:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9BC7618DE;
        Fri,  7 Jul 2023 10:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB07C433C8;
        Fri,  7 Jul 2023 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688726875;
        bh=2+Zvce+UtmPQdPeheWCTBetX0i9tZ7FMJf6ii5G4SH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHm9NStJ4w50skKzyxM3im7oBqdY4W4JckCYR7uICOsvtX0Pf88wjckP0N8LkW7/u
         s/rf4niaJVFMfBin8LlOYr43TDPJNaxSvXuIg7TpKeSa2aLzL/SspVHIfDd5Rd6Hx+
         c5T+FNuIkmRmx0tUkI0zNjHfAVccepxlqKwB9t8HZYy3/3bi3YKyOV6/3h0Pj7PhA2
         vtfhUxnoIiVVN40u4XaWi/7RBujN+ZQ3zHU8/9RUAe2+CLR2ReNRg9W8oI6FWV5eex
         fttyyTxsPSPV9LI+OVRkyGjXCRzFpzQGXUnO5g84h/jgegm/bAQLOG3m9f6r2eiint
         it0UZ3aMk6oqw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHj0f-0005Ee-1s;
        Fri, 07 Jul 2023 12:48:21 +0200
Date:   Fri, 7 Jul 2023 12:48:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
Cc:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>
Subject: Re: [PATCH v8] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZKftdRWz3qf-OFgH@hovoldconsulting.com>
References: <20230601091355.18097-1-quic_tjiang@quicinc.com>
 <d3379b451b2f44f5888060b55ba4a412@quicinc.com>
 <4e60a472b252470db36a065b45d1f605@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e60a472b252470db36a065b45d1f605@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:30:06AM +0000, Tim Jiang (QUIC) wrote:
> 
> 
> Hi Johan Hovold
> 
> 
> 
> I fixed some issue based on your comments in previous version, could you help merge this patch ? thank you.

For a start, you did not even CC me on v8 so how would I know it exists?

I hope someone has told you before, but you should CC people that have
given you feedback when updating a patch.

Second, the patch is question is missing a changelog describing what has
changed since (all) previous versions, so you'd need to fix that before
I'd look at it again.

Johan
