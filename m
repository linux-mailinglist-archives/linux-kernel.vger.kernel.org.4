Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187D76E88F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjDTEFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjDTEFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:05:39 -0400
Received: from mail.heimpalkorhaz.hu (mail.heimpalkorhaz.hu [193.224.51.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD0CE5F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:05:37 -0700 (PDT)
Received: from mail.heimpalkorhaz.hu (localhost [127.0.0.1])
        (Authenticated sender: lmateisz@heimpalkorhaz.hu)
        by mail.heimpalkorhaz.hu (Postfix) with ESMTPA id C677A384A6E170;
        Thu, 20 Apr 2023 02:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.heimpalkorhaz.hu C677A384A6E170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heimpalkorhaz.hu;
        s=default; t=1681951655;
        bh=N2nogFpnFRpTs3l8UZP2CK/VUvCWLBZJbdzLcnyb9VM=;
        h=Date:From:To:Subject:Reply-To:From;
        b=rlJmMyAdmqOgGrdr5YNocOUKgYCs9gUPo9nxmz4Df4H3CEqzarK9iCD8kzDGEB85c
         HuJLldXh4cqZFD5BR6UI0VeUXv2vPudMdkQWO4EGwgSvNbKyIrjc0NbRdl75cPXLKN
         1tr3KxnRIDIasF0fB418PGmFizsgPfZq7CW2kfe2+bKQjQerMq6LOxdYc5tcT13mgO
         2Rke/itmFOutqd07zvJ9LJsNPIirrkJgD5qEtjvTGzSrzlA+EMl62dpkh9DWQFROdJ
         QJkyqS9a3/KSW5tGzARB7NPJQjyFxdbh06LGknw16KEANLXxrQ6BZa8ozRR1IYh7XK
         KtyASOc3Bww4g==
MIME-Version: 1.0
Date:   Thu, 20 Apr 2023 02:47:34 +0200
From:   MK <mk@heimpalkorhaz.hu>
To:     undisclosed-recipients:;
Subject: re:admirer
Reply-To: marion.k07081@gmail.com
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <aa642085c459dec4c9f9f5cc2b8de265@heimpalkorhaz.hu>
X-Sender: mk@heimpalkorhaz.hu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [5.31 / 20.00];
        R_UNDISC_RCPT(3.00)[];
        FORGED_RECIPIENTS(2.00)[m:,s:rh@valueformation.com,s:faithlu@valueline.net,s:johnb@valueshield.net,s:liam.bonfield@valutrades.com,s:pallen@valwood.org,s:jkaat@valyou.net,s:donjorg@valyousat.net,s:ranahs@valyousat.net,s:a.evans@vam.ac.uk,s:g.decruz@vam.ac.uk,s:press.office@vam.ac.uk,s:info@van-ravenstein.nl,s:comercial@vanbet.ro,s:office@vanbet.ro,s:chee.lim@vanderbilt.edu,s:michelle.ardisson@vanderbilt.edu,s:paavo@vanemuine.ee,s:john_gilmore@vanguard.com,s:redak@vanidad.es,s:moda@vanidad.net,s:info@vanilin.hu,s:dan@vannorth.com,s:anne.kroger@vantaa.fi,s:kirjaamo@vantaa.fi,s:loviisa.kaartokallio@vantaa.fi,s:marko.raina@vantaa.fi,s:matti.jaaskivi@vantaa.fi,s:paivi.sihvo@vantaa.fi,s:timo.juurikkala@vantaa.fi,s:anssi.aura@vantaanvihreat.fi,s:eve.ramo@vantaanvihreat.fi,s:minna.kuusela@vantaanvihreat.fi,s:sirpa.pajunen@vantaanvihreat.fi,s:sveta.silvennoinen@vantaanvihreat.fi,s:jgormley@vantageenergyconsulting.com,s:wendy.harper@vantagepnt.com,s:soren.jansson@vap.se,s:ecp@vaquerogroup.com,
 s:varazstorony@varazstorony.hu,s:vdrink@vardadrink.hu,s:info@vardalinzer.hu,s:info@vargatanya.hu,s:fenyvesi.aniko@variens.hu,s:gmankin@varietylease.com,s:maritta@varikset.fi,s:arajanlat@varioszer.hu,s:foepitesz@varoshaza.vac.hu,s:mokanszky.alpolgarmester@varoshaza.vac.hu,s:polgarmester@varoshaza.vac.hu,s:szerkesztoseg@varoskalauz-nyd.hu,s:kozteriovoda@varoskozpontiovoda.hu,s:varoskut@varoskut.hu,s:fallos@vartech.hu,s:linda.purina@vas.gov.lv,s:international@vasasok.hu,s:mikko.koikkalainen@vasemmistoliitto.fi,s:ingo@vasex.hu,s:allas@vasipari.hu,s:krenner@vasiviz.hu,s:sandor.hajas@vaslokft.hu,s:lbrawley@vassar.edu,s:tapio.hayhtio@vasso.fi,s:tapio.salo@vastaanotto.inet.fi,s:bfsoucc@vastbb.net,s:dvnadmin@vastbb.net,s:kandolin@vastbb.net,s:info@vastuzep.hu,s:tours@vaticantoursinc.com,s:jaimala@vatsalya.org,s:mdr@vaughnelectric.com,s:solja@vauvakuvaamo.fi,s:ilang@vax.mtak.hu,s:joev@vazquezcc.com,s:cse-ki-bor@vazsonykom.hu,s:kocsisszilvia@vazsonykom.hu,s:magnus.aspegren@vbm.se,s:john.nelson
 @vbrick.com,s:bayofplenty@vcc.org.nz,s:johnd@vccp.com,s:registrar@vci.ie,s:jbrown@vcomsolutions.com,s:edward.hutcbinson@vcrizon.net,s:doba.zsolt@vcsm.hu,s:bob.anderson@vcsu.edu,s:sebastian.delbrueck@vdivde-it.de,s:kiss.bela@vdsz.hu,s:pecs@vdszsz.hu,s:rick@vecentral.com,s:jkelly@veci.com,s:d_spelich@vecohio.com,s:janki.gyula@vectrasoft.hu,s:patrick@vedanamedia.com,s:teddi@vedur.is,s:joe.noonan@vee24.com,s:jpeeler@veeco.com,s:gerigan@vega.unitbv.ro,s:toocseg@vega.unitbv.ro,s:lina@vegele.lt,s:olah.gyongyi@vegyepszer.hu];
        FAKE_REPLY(1.00)[];
        GENERIC_REPUTATION(-0.59)[-0.58807342704111];
        MIME_GOOD(-0.10)[text/plain];
        BAYES_SPAM(0.00)[20.09%];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+];
        RCVD_COUNT_ZERO(0.00)[0];
        TO_DN_ALL(0.00)[];
        REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
        MID_RHS_MATCH_FROM(0.00)[];
        FROM_HAS_DN(0.00)[];
        RCPT_COUNT_ONE(0.00)[1];
        FREEMAIL_ENVRCPT(0.00)[verizon.net,videotron.ca,vip.163.com,virgilio.it,virgin.net,visto.com,wanadoo.es,wanadoo.fr];
        FREEMAIL_REPLYTO(0.00)[gmail.com];
        HAS_REPLYTO(0.00)[marion.k07081@gmail.com]
X-Rspamd-Queue-Id: C677A384A6E170
X-Rspamd-Server: mail.heimpalkorhaz.hu
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear,

Did you receive my previous email? I'm sorry I'm writing again.

Am sorry to bother you, but I am single and lonely and in need of a 
caring, loving, and romantic companion.

I am a secret admirer and would like to explore the opportunity to learn 
more about each other.

Hopefully, it will be the beginning of long-term communication between 
the both of us.

Please let me know what you think, will be glad to hear from you again.

Hugs and kisses,
Secret admirer
