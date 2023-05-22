Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69E70CD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjEVWLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEVWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F111AF;
        Mon, 22 May 2023 15:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C19862641;
        Mon, 22 May 2023 22:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49BAC433EF;
        Mon, 22 May 2023 22:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684793484;
        bh=20V5Ny16zf6rtURswhWRVf6KSVVAEc7JZQM6Nyij0mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHeTH8wlNIZzp7pmeOU0OayZHfzt0EYwvaZuQutyRGYmJW2jx7L7vx8vfvAYoTMl7
         so5pd5BHV99koNmXtSsYQKBH84Bf23JoBE9jtPvsd1wZWg6ObuAdT0jFHHHR+c7xWw
         MWxZwM0dgHPY4I2TvXUMNo2lRa7UPSiZ7kE/O1LpQxDFr9EGt9Bv3QwFC4e7W5dU4M
         LcS8Kksxrt7qDn/Sd5939hmB2OMqvBa2DsTGEO8BP0rZ0H3llrv9A95x6lWs3ktjVX
         dJakvdIUcAYJDzVtbmZ8BA0IQ4DqdSOp2XxF4x+iZZLq01uQeeg2BMiDuRtBB59w4P
         VNvHmzdMt4tJg==
Date:   Mon, 22 May 2023 16:12:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
Message-ID: <ZGvowPrbPPhxE9Gm@work>
References: <cover.1684358315.git.gustavoars@kernel.org>
 <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
 <yq11qj8nhy7.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq11qj8nhy7.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 06:02:21PM -0400, Martin K. Petersen wrote:
> 
> Applied to 6.5/scsi-staging, thanks!

Thanks, Martin.
--
Gustavo
