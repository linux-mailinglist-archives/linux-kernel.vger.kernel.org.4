Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067685F19AF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiJADrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJADqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:46:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC5C128480;
        Fri, 30 Sep 2022 20:46:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jo24so4907816plb.13;
        Fri, 30 Sep 2022 20:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lBzA4B/TYsozerdKcB4bgC9z78yNHBixXdc+yAYw69M=;
        b=KsVJ9LVSupF/UjzMVjNCt3Gx2MVlWgNmY6JkgBSI5uLNUc5agx3TIBB1OJvn01vUwE
         73iOTo6M/XlJuatgldflzAEPcAl/TjyFOlNJXoWC6RC+O6lgZonGaYSPQu7L9666cMce
         lolhsi5+QjmVNpS97IZexX5NOrhNY+UvRxvOxzRcyWNlrHVEiT/okbfTcZl0h6WSpweF
         VRAov+MZOrGZc6uthfBevOjVUy2OpDNIjiTagR2fco6RTzvaSPmqg5ZWvsOIvDHP4+Rh
         X/yGDgB3Qzl/RjrE3djJzhHfJ3bQ7092sG2gnwQ4CGYKf4TtmTq2v6bg31jkToAc/SFk
         XgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lBzA4B/TYsozerdKcB4bgC9z78yNHBixXdc+yAYw69M=;
        b=rZYTHRPBIvFme2FRKiKHn+0rjiEBz/v1r+yMXVhLqB8xLkWtx1wOD6WGKwQQTZchLJ
         pYZ97IU4rS5dA8k6/Tgz1/ctD6r8MHduRhPignTb/Ni41Wmy6YJLIYIL41hxpZDTeNCm
         cZnUEwDRyxm3Jp5DPBxxRbD3jVeC3DRjfUjY2gArWTg04/n2JeT+dcuIMXZrXkJxuH/S
         D/N0Llw0Reg4211XQihgQIMWDI/xn2aW0M2aAGAxjCnx7lS8YTrZnUpUMMpyLll002Tq
         Z2zVaM1t88kJjh+wpbg4KUHIg5rO5wkILxCmAvVVPNg38bs4EY4f1dOhpq/dTaddt8Td
         +rBg==
X-Gm-Message-State: ACrzQf2n9iUlmgSCPXLHg1DLWyL4DSB+JYDINZOxBVgu4NZS5FHXijny
        Fum74G0OFBo4yH0+kGnvb4o=
X-Google-Smtp-Source: AMsMyM7Xb03Z+AgRjWKJRSf7RVCsqto4/oUQ/FYiK09yUSUZuVzST89CWHz75Jnnta0WPzhSkVjI7A==
X-Received: by 2002:a17:902:b907:b0:178:2898:8084 with SMTP id bf7-20020a170902b90700b0017828988084mr11871814plb.140.1664596012532;
        Fri, 30 Sep 2022 20:46:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id l6-20020a6542c6000000b004277f43b736sm2405422pgp.92.2022.09.30.20.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 20:46:51 -0700 (PDT)
Date:   Fri, 30 Sep 2022 20:46:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] input: Drop empty comment
Message-ID: <Yze4KUiUvcnt+jh5@google.com>
References: <26a2b905b259bfffaf2de5b26f2007b8606970ed.1664478665.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a2b905b259bfffaf2de5b26f2007b8606970ed.1664478665.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:11:36PM +0200, Christophe JAILLET wrote:
> Commit 1a59d1b8e05e ("treewide: Replace GPLv2 boilerplate/reference with
> SPDX - rule 156") has left some empty comment blocks.
> 
> Remove them to save a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Dmitry
