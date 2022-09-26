Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C1B5EB528
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIZXMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIZXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:12:28 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8BAB18A;
        Mon, 26 Sep 2022 16:12:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E4EBD734;
        Mon, 26 Sep 2022 23:12:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E4EBD734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664233947; bh=IoycBVcfegEQ6iOmud3qcL+egsdWLwEFK7jjvLI0xaE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fBjZVd/Tdj/AWthPa7N+9bNu5qflPPWnuzuJRjiB3GTbtoh6PIfAjxoX9azNZ05Xk
         YfYK4ypgtwlBigxuVpabN0TqS2pYw1CqyQ18VA7SqTCkgCUTl+e0JBHY1ELhGtp44C
         J9I2g1/w/U9t4E8wgk+cpjrkzRGm3cceDbZMOTjP0DPUVYegNWn8F7DqNGtX06vSAX
         NrYMWDDob7JXaXGwq/L6Cgw6OdxLOwmNqo3koKK8iq/BxJf+xK1tlqSIsbj8Wo7A7S
         GA7bhzlk00fTzLB0pEpglOTzkGCsAV6gueSRibe6yfxoI8HKBWy2emXavLQXXyW9Cu
         T7p50Ag36Pz3A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        LF TAB <tech-board@lists.linux-foundation.org>
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation
 and practices
In-Reply-To: <20220926211149.2278214-1-kristen@linux.intel.com>
References: <20220926211149.2278214-1-kristen@linux.intel.com>
Date:   Mon, 26 Sep 2022 17:12:26 -0600
Message-ID: <87h70tpw6d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Carlson Accardi <kristen@linux.intel.com> writes:

> The Code of Conduct interpretation does not reflect the current
> practices of the CoC committee or the TAB. Update the documentation
> to remove references to initial committees and boot strap periods
> since it is past that time, and note that the this document
> does serve as the documentation for the CoC committee processes.

Since this takes the TAB's name in vain, they should probably be CC'd on
it; I've added that now.

Thanks,

jon

> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../code-of-conduct-interpretation.rst        | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
> index 4f8a06b00f60..922e0b547bc3 100644
> --- a/Documentation/process/code-of-conduct-interpretation.rst
> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> @@ -127,10 +127,12 @@ are listed at https://kernel.org/code-of-conduct.html.  Members can not
>  access reports made before they joined or after they have left the
>  committee.
>  
> -The initial Code of Conduct Committee consists of volunteer members of
> -the TAB, as well as a professional mediator acting as a neutral third
> -party.  The first task of the committee is to establish documented
> -processes, which will be made public.
> +The Code of Conduct Committee consists of volunteer community members
> +appointed by the TAB, as well as a professional mediator acting as a
> +neutral third party.  The processes the Code of Conduct committee will
> +use to address reports is varied and will depend on the individual
> +circumstance, however, this file serves as documentation for the
> +general process used.
>  
>  Any member of the committee, including the mediator, can be contacted
>  directly if a reporter does not wish to include the full committee in a
> @@ -141,16 +143,16 @@ processes (see above) and consults with the TAB as needed and
>  appropriate, for instance to request and receive information about the
>  kernel community.
>  
> -Any decisions by the committee will be brought to the TAB, for
> -implementation of enforcement with the relevant maintainers if needed.
> -A decision by the Code of Conduct Committee can be overturned by the TAB
> -by a two-thirds vote.
> +Any decisions regarding enforcement recommendations will be brought to
> +the TAB for implementation of enforcement with the relevant maintainers
> +if needed.  A decision by the Code of Conduct Committee can be overturned
> +by the TAB by a two-thirds vote.
>  
>  At quarterly intervals, the Code of Conduct Committee and TAB will
>  provide a report summarizing the anonymised reports that the Code of
>  Conduct committee has received and their status, as well details of any
>  overridden decisions including complete and identifiable voting details.
>  
> -We expect to establish a different process for Code of Conduct Committee
> -staffing beyond the bootstrap period.  This document will be updated
> -with that information when this occurs.
> +Because how we interpret and enforce the Code of Conduct will evolve over
> +time, this document will be updated when necessary to reflect any
> +changes.
> -- 
> 2.37.3
