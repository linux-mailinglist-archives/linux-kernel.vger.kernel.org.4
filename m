Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0506CB23D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC0XU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0XU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:20:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EAE8;
        Mon, 27 Mar 2023 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N+OyLrU+4A8jmyCdWo96SNdqUn8faLNMQEozoY+O+Rs=; b=tyGjobv4NzlVSK/Tg7qsKh4Ksx
        siOpe2LW9dC6L/XowooMNSyqmPckCAW/9AoyV17Jhh1uVweMEb7HHxqau6/OCPwPAZ4WDb32DlnX0
        9ZVR9Cs8zzJDO2QcaGxl6rqbwKWNpySy8rPPxVN780E/LA8kN6zo+jTC4Yu/ykWZbdMQD08/DCBfQ
        LOp+tRH3LjPGrFtNpJ5mXXUIFBlLfqU2lxGcdE8cL55cPn8x+h+HRaNqc/jcLu2kKdkhaIisb93wS
        ilLl72VLqZ8E4NZTCt8JjdXBUxoiUlfNUmRpM2sqUhZeJhceigOwBacX98sa4hPhVD57JOeM6QIwk
        ZwT+UteA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgw8V-00CeAk-38;
        Mon, 27 Mar 2023 23:20:23 +0000
Date:   Mon, 27 Mar 2023 16:20:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: annotate bdev_disk_changed() deprecation with a
 symbol namespace
Message-ID: <ZCIkt3AnNSfvJH/G@infradead.org>
References: <20230327184410.2881786-1-mcgrof@kernel.org>
 <ZCIVx2UNN8VAWYAH@infradead.org>
 <ZCIgavqUnw0Z3A3t@bombadil.infradead.org>
 <ZCIiBHyrzDoTJPXT@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCIiBHyrzDoTJPXT@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:08:52PM -0700, Luis Chamberlain wrote:
> BTW is anyone aware of similar exports which are stuck in this way?

We have a few in fs code.   And there's thing like all kinds of very
low-level code exported that absolutely should only be used by kvm.
