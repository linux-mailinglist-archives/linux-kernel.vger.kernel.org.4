Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75E36F09D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbjD0Q2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjD0Q2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEDB10E;
        Thu, 27 Apr 2023 09:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 465A360F51;
        Thu, 27 Apr 2023 16:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D74BC433D2;
        Thu, 27 Apr 2023 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682612882;
        bh=sygxyc6bJpU/G8GGd4Uas2ekQmIkPh/RJ/FhruQwGxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFjZdV7zhl9uUumZNfu0wBVvnGeZ2hwcuYdUN4cf//dFpowtme6rbXEsEHLh0YcRK
         vU5p9Kzih3lZmZRRAj1SbjOi3YRch9UCalQ5Bh9EzjKrjEwZ35lrNsCEHRhn5DGrFZ
         LU38paKFxKW0TjPidBaqC25hjJO5Z/+QIb8uXcfLVQgdcssXoxGd2MqSvWpBd18ZMz
         dqU5CwLLn/8kT1jvVgKHx5gB78yePAFm+ObHhRtGGYbRURiXn0Rw2m4VdYWnrH+jaX
         OBqdRS6XqwMn99jLMcKHqI1I+a9Q1ZljRMmASgfnIvLx5VY3fqDP1DmCoMUj1+PbRu
         DpT4sC3ILgVGw==
Date:   Thu, 27 Apr 2023 09:28:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: remove some dead code
Message-ID: <ZEqikAnNmjMxuSoU@google.com>
References: <523ec4b037d064e92e19203e3ab9a161e3d9aa71.1681764681.git.christophe.jaillet@wanadoo.fr>
 <2867d5b3-c6cb-49fa-854a-0f58f9a5adb5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2867d5b3-c6cb-49fa-854a-0f58f9a5adb5@kili.mountain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18, Dan Carpenter wrote:
> On Mon, Apr 17, 2023 at 10:51:46PM +0200, Christophe JAILLET wrote:
> >  
> > -	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
> > -	if (!ret)
> > -		ret = ret2;
> > +	ret = filemap_check_errors(NODE_MAPPING(sbi));
> >  
> >  	return ret;
> 
> Let's get rid of "ret" as well:
> 
> 	return filemap_check_errors(NODE_MAPPING(sbi));

Applied with this modification. Thanks.

> 
> regards,
> dan carpenter
