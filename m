Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722BD677128
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjAVRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAVRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:45:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D459DBB95
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ze+/UqVC5efI+msWaBq9Og0ji4xsS9P6nrD3yq7rfLQ=; b=WLFIK6VKKCJnU9ptHo1Jgsqluz
        MOaFRaK6bPEDSCnPx8NFQdQZW1rQoEB1h30hWgknh7Rc9uge+/1GxIb/H7mlGD7eHdcFVFS59RftN
        Qxyftxm4jdffVQKtnXXICvE0hqOyLZEaq+82F8Y34GUe5vQudcYJhjyOBDv7WztREGgKN9XveQktI
        jQ7YGduuv7d16hrNJRCggEyDTd7LEp2us4J1BBOPWPf9PZxHIetW3/5a3GYQ+DagARWQ2uN3VRBf2
        xhz7WMl5mMbxhu9X5glxKh51IsmHu6ZKUrCZYPHmsPBvZFh3oILtSCrLGRhmbfw+cLk6Qxe6Uqw8I
        7IHo2BEA==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJePR-00FbtF-Kr; Sun, 22 Jan 2023 17:45:37 +0000
Message-ID: <f564c135-b03c-6673-d71e-369048b1f8b3@infradead.org>
Date:   Sun, 22 Jan 2023 09:45:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scripts/spelling.txt: add more spelling corrections
Content-Language: en-US
To:     Diederik de Haas <didi.debian@cknow.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <20230122173256.52280-1-didi.debian@cknow.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230122173256.52280-1-didi.debian@cknow.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/23 09:32, Diederik de Haas wrote:
> Current Debian lintian tool flagged several (more) spelling errors, so
> add them so they can hopefully prevented in the future.
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> As requested in https://lore.kernel.org/lkml/CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com/
> 
>  scripts/spelling.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index ded8bcfc0247..d53627fa9b81 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -65,6 +65,7 @@ acumulative||accumulative
>  acumulator||accumulator
>  acutally||actually
>  adapater||adapter
> +adderted||asserted
>  addional||additional
>  additionaly||additionally
>  additonal||additional
> @@ -122,6 +123,7 @@ alue||value
>  ambigious||ambiguous
>  ambigous||ambiguous
>  amoung||among
> +amount of times||number of times
>  amout||amount
>  amplifer||amplifier
>  amplifyer||amplifier
> @@ -287,6 +289,7 @@ capapbilities||capabilities
>  caputure||capture
>  carefuly||carefully
>  cariage||carriage
> +casued||caused
>  catagory||category
>  cehck||check
>  challange||challenge
> @@ -370,6 +373,7 @@ conbination||combination
>  conditionaly||conditionally
>  conditon||condition
>  condtion||condition
> +condtional||conditional
>  conected||connected
>  conector||connector
>  configration||configuration
> @@ -423,6 +427,7 @@ cound||could
>  couter||counter
>  coutner||counter
>  cryptocraphic||cryptographic
> +cummulative||cumulative
>  cunter||counter
>  curently||currently
>  cylic||cyclic
> @@ -627,6 +632,7 @@ existant||existent
>  exixt||exist
>  exlcude||exclude
>  exlcusive||exclusive
> +exlusive||exclusive
>  exmaple||example
>  expecially||especially
>  experies||expires
> @@ -838,6 +844,7 @@ integrety||integrity
>  integrey||integrity
>  intendet||intended
>  intented||intended
> +interal||internal
>  interanl||internal
>  interchangable||interchangeable
>  interferring||interfering
> @@ -1023,6 +1030,7 @@ negotation||negotiation
>  nerver||never
>  nescessary||necessary
>  nessessary||necessary
> +none existent||non-existent
>  noticable||noticeable
>  notication||notification
>  notications||notifications
> @@ -1044,6 +1052,7 @@ occured||occurred
>  occurence||occurrence
>  occure||occurred
>  occuring||occurring
> +ocurrence||occurrence
>  offser||offset
>  offet||offset
>  offlaod||offload
> @@ -1055,6 +1064,7 @@ omitt||omit
>  ommiting||omitting
>  ommitted||omitted
>  onself||oneself
> +onthe||on the
>  ony||only
>  openning||opening
>  operatione||operation
> @@ -1334,6 +1344,7 @@ sacrifying||sacrificing
>  safly||safely
>  safty||safety
>  satify||satisfy
> +satisifed||satisfied
>  savable||saveable
>  scaleing||scaling
>  scaned||scanned
> @@ -1614,6 +1625,7 @@ unuseful||useless
>  unvalid||invalid
>  upate||update
>  upsupported||unsupported
> +upto||up to
>  useable||usable
>  usefule||useful
>  usefull||useful

-- 
~Randy
