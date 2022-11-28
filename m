Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262863ADDE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiK1QeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiK1QeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:34:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1821276
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:34:01 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d6so10673188pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZrRumftBaizemAsvoco9bJQDcA8dR+RDcScEUhYUZA=;
        b=cBeMzCOVAKbyb0oGlPIaXBSgmJOq4eeWjDiqRFkq13TP5lKhAV+2xLds/MR0gv2D6K
         oTp6+dovto0WXWO7GyFx5VfMzFnzu1Ey8ZgLlDKimlbXWaiTF4TVmprfJYEYGsd+q0mD
         kbK5txH8/biSe0oEEuIY/xvtvl3ftTKG0FSlduRhzYZHLvE7vT2TyOdZ0R/t0E5olLy2
         BhzWIoW+biKc0lBONOuINSOO2GhrdqKr/WM+4vtebtQqAwHP/136bMY2jKVGbR6g8kVL
         iOd9un+4cWbcm4k5qecM6BtJLcq3aXR1qiue1ID+7c60NhcePilolxxTcZ+t2kVlKSu3
         Pwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZrRumftBaizemAsvoco9bJQDcA8dR+RDcScEUhYUZA=;
        b=ApeD79ix7TP9VnpLLt3Xicd17/YNfA8bat7uqPGJOhtMMjvpb4qrb+TEN/UyejGnJy
         tyYpeuLTWOi2GgevoLxhdXLXFcMj1lTf/vC+SukGq3/sYUijjjDniNCv5B80seVH8z5q
         +t6idOIto68Ov60pSgZPW2w0wiP7BV1a3PWXvLkI/T+56WTFnsYjiIkg3qhiK8Bf0La6
         ZAgABys/NQgw5/X80QQwyzzJMqMWHPoloT2OMlUy3ittxqyEamxtrNaBs913lv3bbyVv
         ejwVH0daOeSD/73co0R+rK3uTpf8qlDPoOuFpXlPV6cAR/707ToqGeNrK42ke5gyhhKh
         L8kg==
X-Gm-Message-State: ANoB5pnS36C28ke2Aa3atYPqxWE4VcfftSiOgWZGL4SRKObXJzWLriQq
        K70DtUodOLewYfqOpIzixNU=
X-Google-Smtp-Source: AA0mqf6CGHl/Z8L0LBUsPsXLNgGlJ2/BA0bbWKL0mKJ4imQ7UAWjA6fbCoR3TJuODaj/yBPObK4s5Q==
X-Received: by 2002:a17:902:ccc3:b0:189:808b:c659 with SMTP id z3-20020a170902ccc300b00189808bc659mr9181634ple.13.1669653240724;
        Mon, 28 Nov 2022 08:34:00 -0800 (PST)
Received: from localhost ([2600:380:4a6e:888:672c:8d5c:29b8:7830])
        by smtp.gmail.com with ESMTPSA id 19-20020a621413000000b00573eb4a775esm8521634pfu.17.2022.11.28.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:34:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Nov 2022 06:33:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernfs: remove an unused if statement in
 kernfs_path_from_node_locked()
Message-ID: <Y4Ti9vh+vprbyF2W@slm.duckdns.org>
References: <20221126111634.1994-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126111634.1994-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 07:16:34PM +0800, Zhen Lei wrote:
> It makes no sense to call kernfs_path_from_node_locked() with NULL buf,
> and no one is doing that right now.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
