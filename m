Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416645FCBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJLToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJLTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:44:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E5D8EE1;
        Wed, 12 Oct 2022 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jDZ4I851LxUdiiu7BOsIO9+z+vse5KTGadLoaWtLdh4=; b=RR4TAXO9r99InPuIYcVWRn13tS
        Zknncza69nRXINqO+JkA5O6uvwH5DuCovhE7tjj+iHdkEE+n9Y8XCycNWzubW4Q1uIm2daPRJrYdH
        SLbcCEzr+FPzdvv6+DBWR5gjpUoPTKuw0ixZVkqnE1yDBbI7dV08pRZE/84ZYi5xNZrTWX10Qdqrj
        b7cHo6jYdDwWibfY5pAYkIo5TWkfDYMPXMy+hw6aANsRYzWnzMprVuM+FeJZC2VEg8RMQ6ejGnNiO
        Bdy6LzXDj7iEWi90I242qZP1vTCzuGyYAmuNL2hEM7p3oK6Jn+4xSzpSC0iTNXznU9eOhK+V9GLDO
        wAPeYexg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oiheT-000OMs-NC; Wed, 12 Oct 2022 21:44:26 +0200
Message-ID: <fb46724b-f696-c672-fed0-53d844c79151@igalia.com>
Date:   Wed, 12 Oct 2022 16:44:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 4/5] pstore/ram: Set freed addresses to NULL
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-5-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221011200112.731334-5-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 17:01, Kees Cook wrote:
> For good measure, set all the freed addresses to NULL when managing
> przs.
> 
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Tested by building / booting and triggering crashes with efi and ramoops
backends.
Cheers,


Guilherme

