Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1A6FA7E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjEHKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjEHKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2798324ABE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97CCC6274A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C36C4339B;
        Mon,  8 May 2023 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683542100;
        bh=Kiu4+RlvmFWz7J1fJODHws8Y2NusGtgsDOVVjxEOnCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WtKs2lEg83sKkQoekxY7e8UfXjMyKjDpYwxHje7XUmp1Y71T/swsJt/g8S8qx5/oR
         hPeLUfr1NNcD0U4oYLtMv3iRSBBV0I942c6xcLWXz8vfNSbRD7BgFuAeXj5/GmHi9b
         Dnkqvp8oovy9+tEvBpMSQvnMLqbF0GaixIR1gB3YVrTOK8vKA2EtotKO05DboKB7Vi
         GMlKAkWPitsFPCsHJNExiMaQROCEq5yepL6i3CTEzUWOlQZn0sv8aX6tjD4mBeE8Fx
         2C2P4m26ZM6f+inp7ZzuakKxYqMBR/7LH8OUcd+Di7/FOAAEe+3LY3CpaNP3XV82ei
         hi+U3i84r8JoA==
Date:   Mon, 8 May 2023 16:04:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marcin Wierzbicki <mawierzb@cisco.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com
Subject: Re: [PATCH] phy: cadence: Sierra: Add support for SGMII
Message-ID: <ZFjQT1kXG5LHWi/C@matsya>
References: <20230419093008.195094-1-mawierzb@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419093008.195094-1-mawierzb@cisco.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-23, 02:30, Marcin Wierzbicki wrote:
> Added SGMII link support for cdns,sierra-phy-t0 compatibility string.
> The configuration is based on Sierra Programming Guide and
> validated in Cisco CrayAR SoC.

This fails to apply for me, can you please rebase and send

-- 
~Vinod
