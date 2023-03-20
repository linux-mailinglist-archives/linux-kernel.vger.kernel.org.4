Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CEB6C0F91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCTKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCTKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:45:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E57A9D;
        Mon, 20 Mar 2023 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Date:MIME-Version:
        Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:From:Subject
        :Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=S6PJWXorYfxubci0Llo4uduSyji2uSjy0wjtwS9/tr8=; b=aROtAmz/Rxblox23+2ut2cqkb6
        sJNg3+qL1gw1ETWn6T8umzSrt1A2B+jolBZ6Q/mbL1Q1JgLvCbnHg3R/0jYt8gyF3k+Q00zD3KRiY
        zDSMxK5AOLVsFA9gJIKqJe6yw+x+CcYUala7PIt9nTnwEFAuj28EuLQy0WANsgGQ6pthweqFFka9Z
        EekcbYXTN6HN9kB+aQ8o0vVqYeikpetPHQL4/sAZ2Rjaa5nTPiOLLmVRbF7aB9mES5p9iC8PPHMeC
        AV1HwEbRa/FXTW4udynlYKX+QZ0CCrKy5ZQOGlJ1IRr9EAQQMEYv/c943lcMusLj9/SMkSXNnvV2M
        t/on2o8A==;
Received: from [54.239.6.186] (helo=edge-cache-203.e-hkg50.amazon.com)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peCy4-003tXs-0r;
        Mon, 20 Mar 2023 10:42:20 +0000
Message-ID: <8e05c7e2af238cdbcce1177e8684e192a71421b9.camel@infradead.org>
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
From:   Amit Shah <amit@infradead.org>
To:     bchalios@amazon.es, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        amit@kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk
In-Reply-To: <5441d09dc213998042a337b7f411bd1662b604bc.camel@infradead.org>
References: <20230131145543.86369-1-bchalios@amazon.es>
         <Y9lBeymca9eFaJ33@zx2c4.com>
         <65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org>
         <e1c03136-b873-1f1d-8b06-d9186566fc0c@amazon.es>
         <5441d09dc213998042a337b7f411bd1662b604bc.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 20 Mar 2023 11:42:02 +0100
User-Agent: Evolution 3.44.4-0ubuntu1 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-13 at 19:05 +0100, Amit Shah wrote:
> Hey Herbert / Jason / crypto maintainers,

[...]

> Let's wait a couple more days for responses, otherwise I suggest you
> resubmit to kickstart a new discussion, with the note that Jason had
> something else in mind - so that it doesn't appear as though we're
> trying to override that.

I reached out to Jason on IRC, and he mentioned he will follow up with
a patch that incorporates ideas from your patch plus hooking into
random.c.  Sounds promising!

		Amit
