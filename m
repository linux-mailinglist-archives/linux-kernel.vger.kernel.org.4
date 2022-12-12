Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3637B64A758
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiLLSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiLLSnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:43:07 -0500
X-Greylist: delayed 2496 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 10:39:45 PST
Received: from fallback21.mail.ru (fallback21.m.smailru.net [94.100.176.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1EC1759E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=G4BTKWN2LtadE3xtP4W7JTWNWm2U1sx29SGq9LHxKYc=;
        t=1670870385;x=1670960385; 
        b=isyyH3Uj81wVrGqGlkZW/Goz5McE0jSKnMTm8cIuCzpcimsg5eCN5lXdD8fv5OgOXUgyWzVsdmgCKIwcJj9eRud4jPVIW+N+T+i6ZgghI33bAE5bgfnywDbR2rqDsnJGH6Bi5uVuojlZaDkgoD/unjHSLY2gUEoXSl6ulLKNxw8zQ7q1v/YgqrCbUNhTNtw5Z1mjEG/kzMPMB+osgWQes9aj0MqzsbcF6O8ZMagTOfZ3DlaLrBWDHkVGG5QnxgX+/dINJelfgQ0F5iJUEMTjodGBR2NQQt7QkEn5Z/zAZSAIQd12FOPbuClDssrYqhMEdMIFrmQZpDhf3BO6GWbVWw==;
Received: from [10.161.55.49] (port=35158 helo=smtpng1.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1p4n42-0002AW-Au; Mon, 12 Dec 2022 20:58:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=G4BTKWN2LtadE3xtP4W7JTWNWm2U1sx29SGq9LHxKYc=;
        t=1670867886;x=1670957886; 
        b=QMGukM/U2Pivg9J/WW+4anQ7c7twgMMv0hvOhrIFlNfPMOBzMwo/xx2moX2c6WYypaz6VCfHRlkA3TREOH04susBGiT1ND4Vot/s61FC73PB4zXp0YGRP/d0AjaNkEDpiYNsNr8boKnFsijpQHKqpRJMhSDpGDcfb1XyWDyYNGuAdbZMkNZNDEUgiDtaVpsF0MpiSIUJt13bK0f79BRExVrI++Pd9yhPvtDXnOaxPyNIpv+Tii/0IlMXA/g62okzArQc92fh7QV2YSO40ZkNIXsIpFXuum1na2WGOv/MjE+4KZy9FdohcOIi/5v9XhdyC3eJ06rC3+A+cOZEpFskcg==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1p4n3m-0000Qy-Di; Mon, 12 Dec 2022 20:57:51 +0300
Message-ID: <b75a8769-0cc8-beb3-931a-6755aede3af0@inbox.ru>
Date:   Mon, 12 Dec 2022 20:57:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: nvmem-cells regression after adding 'call of_platform_populate()
 for MTD partitions'
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
 <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
 <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info>
 <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
 <20221212101449.4e465181@xps-13>
 <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
 <20221212173730.64224599@xps-13>
Content-Language: en-US
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20221212173730.64224599@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD90D1502B3BE350FE460E08CDB322628C398144F1A0CCA906500894C459B0CD1B9ABB20FF08B14F5A20B1E811E86927F87078B5411FB1F25F4F5EC2512189958EF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BB17EE3498E810FEEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379BF04B24BEB7B2D58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8590D056553F31FF1002A9CEDDAE84B036F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE70F3DDF2BBF19B93A9FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B6D77D8F98F67F34EA471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CAA44A86D94E7BBB043847C11F186F3C59DAA53EE0834AAEE
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3435BBF0AC4E3A921CB2F5EB4DC98AB3F4CCE54E6FE01DD48C65728CE7034F86891F03023C34D809491D7E09C32AA3244C4E824EC1D2FB3A5A2A0C928044C56FD939C99C45E8D137E90D282625F6E20647
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojCvDLVb3lQJjtlBj9YOdmFw==
X-Mailru-Sender: 689FA8AB762F73933AF1F914F131DBF526D060A6CE773BB8005E62F5CE2FE9F598CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41CF11DA7185A12D6AF94C6C0AA204E121E04F18B7EFB96AB68F3CF0E9FE49B69898535FB3DA75E9DF65047860D550BE3CAA35A703C305B3F8CDFFDA51A1FDAC9
X-7FA49CB5: 0D63561A33F958A56AE1C15E971E7E3A6F9FF09E754BC4B5F9EA91A82B543CCDCACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637006720155ACF5028389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC86FF1B927F95F3316F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE74F0F518E68DBD4F843847C11F186F3C59DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojCvDLVb3lQJjHvEQaERF/5Q==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miquel!

On 12.12.2022 19:37, Miquel Raynal wrote:

> Let me try to recap the situation for all the people I just involved:
> 
> * An Ethernet driver gets its mac address from an nvmem cell. The
>    Ethernet controller DT node then has an "nvmem-cells" property
>    pointing towards an nvmem cell.
> * The nvmem cell comes from an mtd partition.
> * The mtd partition is flagged with a particular compatible
>    (which is also named "nvmem-cells") to tell the kernel that the node
>    produces nvmem cells.
> * The mtd partition itself has no driver, but is the child node of a
>    "partitions" container which has one (in this case,
>    "fixed-partitions", see the snippet below).
> 
> Because the "nvmem-cells" property of the Ethernet node points at the
> nvmem-cell node, the core create a device link between the Ethernet
> controller (consumer) and the mtd partition (producer).
> 
> The device link in this case will never be satisfied because no driver
> matches the "nvmem-cells" compatible of the partition node.
> 
> Reverting commit bcdf0315a61a ("mtd: call of_platform_populate() for MTD
> partitions") would IMHO not make much sense, the problem comes from the
> device link side and even there, there is nothing really "wrong",
> because I really expect the mtd device to be ready before the
> Ethernet controller probe, the device link is legitimate.
> 
> So I would like to explore other alternatives. Here are a bunch of
> ideas, but I'm open:

How about to create simple driver with compatible="nvmem-cell" and to 
move all the suff from main mtd driver which serves nvmem-cell to the 
probe function?

Thanks, Maxim.
