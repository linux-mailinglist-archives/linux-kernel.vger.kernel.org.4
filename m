Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815626C9248
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCZDxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCZDxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B746B461
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3365C60D32
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 03:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B6C433D2;
        Sun, 26 Mar 2023 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679802783;
        bh=RF6N9FVB3DivyoIx0C73mEw6zoogCODNFdFMIq0xZuw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=naIuWWlPpbSfMczMPHstX2SNjWeBSwif2zJ7NElVzl/1us2RRpROsT8kia5Plsxxa
         /nbjvIs0l68FkbpHxzhaSnNMwYVegOlLC7lUwIppFbULi/daAJ04Dghx0Kh42KWBk8
         z02CJZBwpYQgP5JpNC4HM67IBcBTG7uWtbCes6fLjjPo+JMCoti01cyTz3bI/K9dYS
         THAJTu1TsFAqt2dTz9tqWD4rb7kbrCmI+gfVG8UX3vXTekX29lFPRus6OpDjED5Ifv
         K+uCtG8fKb+s7CJ6pFiXvp/wOwktEymu3hmiHSrh/53F/kLoMXNAyhBA+loAqdCZdD
         6/6WpP3GBgo5Q==
Message-ID: <3b2c0df6-fedf-8941-9242-6f6571ad7372@kernel.org>
Date:   Sun, 26 Mar 2023 11:53:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: apply zone capacity to all zone type
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230321231157.963598-1-jaegeuk@kernel.org>
 <ZBo/QcTFUiqRafLC@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZBo/QcTFUiqRafLC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/22 7:35, Jaegeuk Kim wrote:
> On 03/21, Jaegeuk Kim wrote:
>> If we manage the zone capacity per zone type, it'll break the GC assumption.
>> And, the current logic complains valid block count mismatch.
>> Let's apply zone capacity to all zone type, if specified.
>>
> 
> Added:
> 
> Fixes: de881df97768 ("f2fs: support zone capacity less than zone size")
> 
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
