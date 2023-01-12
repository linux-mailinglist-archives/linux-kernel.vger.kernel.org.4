Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9510C6684A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbjALUza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbjALUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:30 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266062C3;
        Thu, 12 Jan 2023 12:33:31 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5E26B6E3;
        Thu, 12 Jan 2023 20:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5E26B6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673555611; bh=isSAsl/11UcncYQsH4oIAI2PgAG9STANENU4NGco10g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=K3qkWwyUjUdoxU5PYH96xIH81+5GQFA8ZkR80BWFS+qmvdPPptnDhnw+QclImpZl9
         oLfarofcCbA4tgytHYDN6vAAxJsJoVgzzZi9gUvfcbGmskU0MzicARPUqXwTjOutQM
         c2fBnW40YQAg0jcYP7ElpI2ea60/c/jlWU1bmoeM0+xnjWSOcZNHSC4NRiRMLSHmTN
         eIAg4L+50h2Jw15XzmcCkTbJ+vUk2AjaoeDYTNgWuPZODVmL8SsHBsRZIgc63ruwyM
         dKsb05SvCGXaGhHEIjcAo+YMASWKPDrYmhQWTKbKzOIfq4c7D1taI90DLYjj8Ym9+p
         HcS57nGDRGn4w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc: monospace style for inline code in botching ioctl
In-Reply-To: <20230112195552.qapndatj66nqmu4n@numero-86.vaga.pv.it>
References: <20230102183649.9626-1-federico.vaga@vaga.pv.it>
 <874jswwuc2.fsf@meer.lwn.net>
 <20230112195552.qapndatj66nqmu4n@numero-86.vaga.pv.it>
Date:   Thu, 12 Jan 2023 13:33:30 -0700
Message-ID: <87cz7jtrvp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> On Wed, Jan 11, 2023 at 03:59:57PM -0700, Jonathan Corbet wrote:
>>Federico Vaga <federico.vaga@vaga.pv.it> writes:
>>
>>> Highlighting inline code improves text readability.
>>>
>>> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>>
>>It improves *HTML* text readability; the results for plain text are
>>... less clear.  I think it's better to avoid this kind of extra markup
>>when we can.
>
> Shouldn't we consider higher priority the HTML text? Perhaps I've a biased
> opinion. Do you think that plain-text is the favorite way of reading the kernel
> documentation?

The policy all along has been that we need to prioritize the plain-text
docs.  A lot of people do use them, and it is easy to wreck their
readability with markup if sufficient attention isn't paid.  HTML output
is great, and we want it to be as good as it can be, but it can't be at
the cost of plain-text readability.

> Let me profit from this point and ask. Are there statistics about the usage of
> https://www.kernel.org/doc/html/latest/?

None that I know of.

Thanks,

jon
