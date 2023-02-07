Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356D68DA25
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjBGOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjBGOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:07:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D481701
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675778803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJ8JQZnG+OjlrDJJhK5LXF+fnEiLqDMUtskISvma+18=;
        b=SA/KS42Mq6VcU6Kui97JUpP9l/WsvLnGDf7IDmmH1cOv/WpjLjueS6eQ9T8IdJxprt6YOF
        9gAYYhLfmhGp0qax8g4fnvhTqSnafzuFq3zP4U5ZBcY3TdbgE8i+izZw0IcDlqRe8i2G06
        /girXck4Tnhfrq8bb5fU+iwWUcHupj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-jk5hakyWNLOpXo0vfUGfuw-1; Tue, 07 Feb 2023 09:06:37 -0500
X-MC-Unique: jk5hakyWNLOpXo0vfUGfuw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31BB5803D48;
        Tue,  7 Feb 2023 14:06:37 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 363E2492B21;
        Tue,  7 Feb 2023 14:06:32 +0000 (UTC)
Date:   Tue, 7 Feb 2023 22:06:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RESEND 1/3] ublk: remove unnecessary NULL check in
 ublk_rq_has_data()
Message-ID: <Y+Ja45X5pmY6SrZP@T590>
References: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
 <20230207070839.370817-2-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207070839.370817-2-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:08:37PM +0800, Ziyang Zhang wrote:
> bio_has_data() allows a NULL bio so the NULL check in
> ublk_rq_has_data() is unnecessary.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

