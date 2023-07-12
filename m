Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F04974FD0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGLC0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGLC0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:26:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C431720;
        Tue, 11 Jul 2023 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=75v9CfeFEwnQ5bgOfSgo93MccHagFqXJtorhobp7Ifo=; b=dBTmwmyHWb13IzIO7HXTlmLuLq
        xzW5r+8FZdYt0iyaYD+oDC57+UwFHqGVk1I6RTc3h0DYvt5CWGxZfjlZUASbqiQifcymVz+q5HMnp
        9qgP+J29bZbCo3gZjz0vZb0ThF2lwNmGRJkZXtwZ2z6/fzS+OWOYypnNtlBcwfE7GlLcsiVHM+HjE
        aY6ogjD/6Ym7eY2sBgA2J5ZoUHfaLlO67Wu3a9c9McgubQF3mC3gXvMWgRstR14krrqpgGm88OViC
        ipV1Ry/un3jp6RLJYkjiDsW0rWjk0skW5RibalwnG7DnMjXc2YH2ZlMNP4pIXX7/ovEF5j+00zRUx
        zDaGWTvg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJPYo-00GG8x-1A;
        Wed, 12 Jul 2023 02:26:34 +0000
Message-ID: <53602f8f-c37b-6570-d76d-5dd3c3329280@infradead.org>
Date:   Tue, 11 Jul 2023 19:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: build warnings after merge of the amdgpu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221118175545.762d1a20@canb.auug.org.au>
 <20230712091509.4f6f7a19@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712091509.4f6f7a19@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 16:15, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 18 Nov 2022 17:55:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the amdgpu tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'dispclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'actual_dispclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'dppclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'actual_dppclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'disp_dpp_voltage_level_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'dcfclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'socclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'dcfclk_deep_sleep_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'fclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'phyclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'dramclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'p_state_change_support' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'zstate_support' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'dtbclk_en' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'ref_dtbclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'fclk_p_state_change_support' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'pwr_state' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'prev_p_state_change_support' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'fclk_prev_p_state_change_support' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'num_ways' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'fw_based_mclk_switching' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'fw_based_mclk_switching_shut_down' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'prev_num_ways' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'dtm_level' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'max_supported_dppclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'max_supported_dispclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'bw_dppclk_khz' not described in 'dc_clocks'
>> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or member 'bw_dispclk_khz' not described in 'dc_clocks'
>>
>> Introduced by commit
>>
>>   1682bd1a6b5f ("drm/amd/display: Expand kernel doc for DC")
>>
>> (now also in the drm tree) but revealed by commit
>>
>>   ef8d147fd442 ("drm/amd/display: fix kernel-doc issues in dc.h")
> 
> I am still getting these warnings (presumably now from Linus' tree).
> The line number has changed to 558.

This patch:
https://lore.kernel.org/lkml/20230712022339.17902-1-rdunlap@infradead.org/T/#u

removes all 175 kernel-doc warnings from dc.h.

-- 
~Randy
