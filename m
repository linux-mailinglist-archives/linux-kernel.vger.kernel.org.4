Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C065B54A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjABQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjABQsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:48:31 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A60243;
        Mon,  2 Jan 2023 08:48:29 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 98F68419AE;
        Mon,  2 Jan 2023 17:48:27 +0100 (CET)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=dkim20160331; t=
        1672678107; x=1674492508; bh=hztdjnmy+E8oSCGGaVOT/eEUJOCE8+rS8Pj
        T7AjbB3s=; b=qeJ7lVNIWbA/hNfwnbnPs7wWOIGIS0nXvuNLzDoROT8OoEBxhVf
        wUqDUxOSnHa0AXEM1BrvuBaGsvRBUitYf36UoUJq0CmCPTvollLpnWIzBBsZhlvV
        AErugJsW3FpnfiFzdI5RQ9PxcWc8AV8SOg0NoWvDVwxDBhj144p45iVyyyfQGt0W
        JLMnoBBRb6oTwADvKE7bYbj5KX6/EUtGcnhz/2votIPBwzgfZaXfkYFD8UKOveUV
        yT7+Noz5LsJe5PbhvwxaoYPXwGgvqIsdKwwT23kq+LG34RwQMCbSlCG3wvE/NZG+
        qpoWpFsENIy8q9oLqVaSwApuSQeAG52mFYuxNUSeRkHidSrYhp+XrrcQBspqgU3O
        ehJzrAa/IJmVJlTgLg1jncuV8Va82XbbG5Z75wVkq5eLDgCq9ZWGxXuSgrePmX63
        Y/oZFJKeRm4Kp3Zt3HUaYAFNaJcDcE9/Md3PR4tZBNF9gFUOq5BlA66A926eTZsc
        gk+jWmkWPyo/h4GX4bYLCoZwi+VdK84MR2XpIrWWvt4hep2ot3qrQpiXzGTiEQav
        ZYEbYjuG5aJjcrWHDyFM/ZI9T8fWoqyjLJ+phYAkR/Nozt3bDrXRRGhnJP0FMGbK
        bnsO+mFdRLu16pOkhQt5EZqJLz05v33EWqiYYr2/cXyn+DR1zZzasgDQ=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RQxyvTnCS89F; Mon,  2 Jan 2023 17:48:27 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 5CD8E4194F;
        Mon,  2 Jan 2023 17:48:26 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id E7DC21B67;
        Mon,  2 Jan 2023 17:48:25 +0100 (CET)
Date:   Mon, 2 Jan 2023 17:48:23 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: monospace style for inline code in botching ioctl
Message-ID: <20230102164823.fr5rw6idkjkxa74d@numero-86.vaga.pv.it>
References: <20230101132758.12560-1-federico.vaga@vaga.pv.it>
 <Y7LtxnBKkpCmx83I@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y7LtxnBKkpCmx83I@casper.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 02:44:22PM +0000, Matthew Wilcox wrote:
>On Sun, Jan 01, 2023 at 02:27:58PM +0100, Federico Vaga wrote:
>> +   that diminishes the checking tools like sparse can provide. The macro
>> +   ``u64_to_user_ptr`` can be used in the kernel to avoid warnings about
>
>Should probably be u64_to_user_ptr() instead to get both the monospace &
>the hyperlink.

Indeed, good point. A V2 will come

-- 
Federico Vaga
