Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9571091B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbjEYJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240828AbjEYJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:39:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7DA9
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VpuaHp/o7Il2YlDzKUSM0hdJY8pqkR5NkWfsD7YnoUo=; b=w/Eh+TLCuq0AR7mLIO7A9SXEhT
        api7vTY9f/uYb1qQjLYvTx+fwtAa/kVVrlyC634jAdFrpHNw0KlPpzCNfkgGS46H5jFM50IxCXoz0
        dRF9mMWQJ+iBtc70LzJ3h8K4PO8Owettk6K8PSgAj5vDd6AGJs07J2HHSoeN+TBoa0lAfcQlpuL0X
        wxdpYdCgB88QFPnjahz1vqPYTyOYP2a3P402+jmX2ixDvwll9PvVnQ2kf0Y9DpfJ5aeMUglV4rGJs
        GqvIKXbLBO4AY+JuieWaimRiJFXXYe4RZUfRAIcW3RL+NXaCwUKVSwLY5y78+j5vwQB8hoJwwyKvb
        N6hoP2aA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q27RY-00GApj-2N;
        Thu, 25 May 2023 09:39:36 +0000
Date:   Thu, 25 May 2023 02:39:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     arnd@arndb.de, andriy.shevchenko@intel.com,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2 2/2] misc: enclosure: update sysfs api
Message-ID: <ZG8s2EV0xvNH+0Cb@infradead.org>
References: <20230524111231.14506-1-mariusz.tkaczyk@linux.intel.com>
 <20230524111231.14506-3-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524111231.14506-3-mariusz.tkaczyk@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 01:12:31PM +0200, Mariusz Tkaczyk wrote:
> Use DEVICE_ATTR RW and RO macros. Update function names accordingly.
> No functional changes intended.

The subject looks a bit, I'd say something like:

"enclosure: use DEVICE_ATTR_RW* macros"

instead.

The actual changes look good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
