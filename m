Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3144697F22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBOPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBOPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:08:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D12225976
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2BED61A9C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B87BC433D2;
        Wed, 15 Feb 2023 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676473714;
        bh=8+v/ksbJ9IhwSwboFHhH0kzBpXcx9X+LYE4dd6F7FxM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RfMp0Fs63+GtNKj+E0uAX7/1uI+WJTA8dhK5bI7IjW6tCDpd7PGU+3Tnb4CIrzJw5
         Gu6l7sRRzlHKQBlMeTVtLFhy68phJ5jo4AQ/pFp8mu4ids0zB5jayrcmH+YdOIkOAK
         1b408F5KrnTeb03nZri0w3qK+lwde4FA2yu3X/bmYc++3I4IO0IW7mSgYpwQ8BHXPH
         uiUMI/XjuDOaHQt76YbOZDT5x2j/6lPdUzNsOEUIpCEJw1Dt3NVP2x0/cjE0h33bFZ
         L3S6diUY3vuAxBkPnmlF7i1QuVxSSwBeP2YmfHsSuvjzNLs6Cl5cSeO01ATtDU5pES
         qTOsjVKYw63/Q==
Message-ID: <cf8937f3-6aa3-811e-c862-bb409511d8ad@kernel.org>
Date:   Wed, 15 Feb 2023 23:08:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: drop unnecessary arg for f2fs_ioc_*()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230215061701.1433-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230215061701.1433-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/15 14:17, Yangtao Li wrote:
> They are not used, let's remove them.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
