Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA15B728909
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjFHTwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjFHTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:52:33 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27A2D52;
        Thu,  8 Jun 2023 12:52:32 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-777b4560ae8so47499339f.2;
        Thu, 08 Jun 2023 12:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253951; x=1688845951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytP9VHFEilCQC/4sa+SiOu9bJAvA3XfhPN+W1x7420c=;
        b=aJlRgiFBfZwI/lA/FRVtrwbZfBqke5nv3Km/n36xcfzDT5nNi6Z8fUCRVkU6e9Af4H
         GlMh/sofw6nTLiQ3AjP84c4HsMuqZV/Rt0wnsyXKP5suy1iuN2K587B2hHTYMFix3sp0
         fWojBtrjmKK13t2MOSFIs9q+oeE4SMVF7XOCxZctxQyA/HCDJOAkJoH0ceCxAwBmoIcJ
         mMOUdkpcAk0zE2DN3FY2RzcG3bewUfAR7sGClVDpgkuKS7Q93kyyXpp9onEx00wWhRXU
         +c/SQJPnaGgnpUNbV6LeKEUNXROKge/5hPoAV71qLcPc+Pdpj1SH/Vj4Hrw3p1EuIYbc
         mf8g==
X-Gm-Message-State: AC+VfDw8iW85PEtbM3uyMXt8YPn4wlq92EOyWw0WNYkxC33hLwzk5NLv
        fJXPL31xD4FikNlYlhyRkQ==
X-Google-Smtp-Source: ACHHUZ6O8PmQyh1KDrI24+TTH4v63md3xk4kA4Rxe3ARKoORCwCxta6RdFsg/WJx8v7b/I19sBmf/w==
X-Received: by 2002:a6b:db13:0:b0:777:84d7:8e77 with SMTP id t19-20020a6bdb13000000b0077784d78e77mr9629238ioc.14.1686253951138;
        Thu, 08 Jun 2023 12:52:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d7-20020a5e8a07000000b00760e7a343c1sm562969iok.30.2023.06.08.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:52:30 -0700 (PDT)
Received: (nullmailer pid 3294192 invoked by uid 1000);
        Thu, 08 Jun 2023 19:52:28 -0000
Date:   Thu, 8 Jun 2023 13:52:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add microchip MCP3561/2/4R
 devices
Message-ID: <20230608195228.GA3290206-robh@kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5ebab164-53fc-4492-bb76-5cc2d7b3f4f0@emailsignatures365.codetwo.com>
 <20230523124354.24294-1-mike.looijmans@topic.nl>
 <20230523-panning-surplus-b9072e18905b@spud>
 <f68b1370-3968-5bfe-5875-26abf868a846@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68b1370-3968-5bfe-5875-26abf868a846@topic.nl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:02:39AM +0200, Mike Looijmans wrote:
> On 23-05-2023 18:00, Conor Dooley wrote:
> > On Tue, May 23, 2023 at 02:43:53PM +0200, Mike Looijmans wrote:
> > > The MCP3564R is a 24-bit ADC with 8 multiplexed inputs. The MCP3561R is
> > > the same device with 2 inputs, the MCP3562R has 4 inputs. The device
> > > contains one ADC and a multiplexer to select the inputs to the ADC.
> > 
> > My favourite - nothing for a while & then two come along almost at once!
> > https://lore.kernel.org/all/20230519160145.44208-2-marius.cristea@microchip.com/
> > 
> > Would you mind, since he seems to have sent it first, reviewing his
> > series?
> > 
> 
> Oh, damn. Want to, just have to figure out how I can reply to mails that I
> never got (had delivery turned off for linux-iio). Tips welcome (just send
> to me personally...)

b4 is The Way. Assuming you have mutt setup to reply, just pass a msgid 
or lore url to this script:

#!/bin/sh -e

if [ -z $1 ]; then
        echo "Usage: $0 [b4 mbox options] <messageId>"
        exit 1
fi

msgid=$1

tmpfile=$(mktemp)

b4 mbox -o - "$*" > $tmpfile
mutt -f $tmpfile

rm $tmpfile
