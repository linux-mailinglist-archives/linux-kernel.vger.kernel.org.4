Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BF0665CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjAKNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbjAKNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A63881
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7158761D1C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E321DC433EF;
        Wed, 11 Jan 2023 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443857;
        bh=QSRDEhjQOIo+1Nf6WjkaaVUOZYxoWbLk6Ng5D63wRtk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oZiIJdF6H8ADKwN3l2+goyFyMDs29JZDKum+lywwyA8Oj2xnomUR/PyFk/eT6DXKl
         P8YYzAkKiSgXhgHLlC03Rwrl7Z36MP6RvWFDjwB8J9NnFBOgePLTw5Q7mHtphMomvo
         mmIl2OkjFzGS2WQzLBs6GoOKYMfQpF+xuY7LSyC6QQgjd+Z1U19nPV3T/1iwfd5+kj
         X+vZSdMmPCwU4zPHQKrUBMvufd0M6QwhgokNPR6d1rpClVPxleHLLZDnPWRjR/mutD
         w8p8cwt6N4vc5C8zpCMWS+CGrM1NzegJaSjvn24oke3G6snbbdIzmAk5klds/RVaaE
         i3KPExJbosgvg==
Message-ID: <8d71e53b-3ca0-3c84-acf0-5e8ec0952cc3@kernel.org>
Date:   Wed, 11 Jan 2023 21:30:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] f2fs: merge f2fs_show_injection_info() into
 time_to_inject()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221220183904.53908-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221220183904.53908-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/21 2:39, Yangtao Li wrote:
> There is no need to additionally use f2fs_show_injection_info()
> to output information. Concatenate time_to_inject() and
> __time_to_inject() via a macro. In the new __time_to_inject()
> function, pass in the caller function name and parent function.
> 
> In this way, we no longer need the f2fs_show_injection_info() function,
> and let's remove it.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
